from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from backend.models import Urun, Kimyasal, Kumas, Stokhareket

from backend.database import get_db
from backend import models
from backend.schemas.stokhareket import (
    StokHareketCreate,
    StokHareketResponse
)
from backend.core.enums import MovementType



router = APIRouter(
    prefix="/stokhareket",
    tags=["Stok Hareket"]
)

# =========================
# STOK HAREKET OLUŞTUR
# =========================
@router.post("/", response_model=StokHareketResponse)
def create_stok_hareket(
    hareket: StokHareketCreate,
    db: Session = Depends(get_db)
):

    # -------------------------
    # ENTITY BUL
    # -------------------------
    if hareket.entitytype == "urun":
        item = db.query(Urun).filter(Urun.id == hareket.entity_id).first()

    elif hareket.entitytype == "kumas":
        item = db.query(Kumas).filter(Kumas.id == hareket.entity_id).first()

    elif hareket.entitytype == "kimyasal":
        item = db.query(Kimyasal).filter(Kimyasal.id == hareket.entity_id).first()

    else:
        raise HTTPException(status_code=400, detail="Geçersiz entitytype")

    if not item:
        raise HTTPException(status_code=404, detail="Kayıt bulunamadı")

    # -------------------------
    # STOK HESAPLA
    # -------------------------
    onceki_stok = item.miktar

    if hareket.harekettipi == MovementType.giris:
        yeni_stok = onceki_stok + hareket.miktar

    else:
        if hareket.miktar > onceki_stok:
            raise HTTPException(status_code=400, detail="Yetersiz stok")

        yeni_stok = onceki_stok - hareket.miktar

    item.miktar = yeni_stok

    # -------------------------
    # LOG KAYDI
    # -------------------------
    log = Stokhareket(
        entitytype=hareket.entitytype,
        entity_id=hareket.entity_id,
        harekettipi=hareket.harekettipi,
        miktar=hareket.miktar,
        oncekistok=onceki_stok,
        sonrakistok=yeni_stok,
        aciklama=hareket.aciklama,
    )

    db.add(log)
    db.commit()
    db.refresh(log)

    return log


# =========================
# TÜM STOK ÜRÜNLERİ (FLUTTER İÇİN)
# =========================
@router.get("/items")
def get_items(db: Session = Depends(get_db)):

    urunler = db.query(Urun).all()
    kimyasallar = db.query(Kimyasal).all()
    kumaslar = db.query(Kumas).all()

    return (
        [{"id": u.id, "name": u.ad, "type": "urun"} for u in urunler] +
        [{"id": k.id, "name": k.ad, "type": "kimyasal"} for k in kimyasallar] +
        [{"id": k.id, "name": k.ad, "type": "kumas"} for k in kumaslar]
    )