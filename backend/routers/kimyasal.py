from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from datetime import datetime
import backend.models as models
from backend.database import get_db
from backend.schemas.kimyasal import (
    KimyasalCreate,
    KimyasalResponse,
    KimyasalBase
)
router = APIRouter(
    prefix="/kimyasal",
    tags=["Kimyasal"]
)

def active(query):
    return query.filter(models.Kimyasal.is_deleted == False)

@router.post(
    "/",
    response_model=KimyasalResponse,
    status_code=status.HTTP_201_CREATED
)
def create_kimyasal(
    item: KimyasalBase,
    db: Session = Depends(get_db)
):
    yeni_urun = models.Kimyasal(**item.model_dump())
    db.add(yeni_urun)
    db.commit()
    db.refresh(yeni_urun)
    return yeni_urun

@router.get("/", response_model=List[KimyasalResponse])
def get_kimyasal(
    db: Session = Depends(get_db),
    skip: int = 0,
    limit: int = 10
):
    result = (
        db.query(models.Kimyasal)
        .filter(models.Kimyasal.is_deleted == False)
        .offset(skip)
        .limit(limit)
        .all()
    )
    return result

@router.put("/{id}", response_model=KimyasalResponse)
def update_kimyasal(
    id: int,
    item: KimyasalCreate,
    db: Session = Depends(get_db)
):
    db_item = db.query(models.Kimyasal).filter(
        models.Kimyasal.id == id
    ).first()
    if not db_item:
        raise HTTPException(
            status_code=404,
            detail="Bulunamadı"
        )
    for key, value in item.model_dump(exclude_unset=True).items():
        if key != "id":
            setattr(db_item, key, value)
    db.commit()
    db.refresh(db_item)
    return db_item

@router.delete("/{id}", status_code=status.HTTP_204_NO_CONTENT)
def del_kimyasal(
    id: int,
    db: Session = Depends(get_db)
):
    db_item = db.query(models.Kimyasal).filter(
        models.Kimyasal.id == id
    ).first()
    if not db_item:
        raise HTTPException(
            status_code=404,
            detail="Ürün bulunamadı"
        )
    db_item.is_deleted = True
    db.commit()
    return None


# SEARCH
@router.get("/search", response_model=List[KimyasalResponse])
def search_kimyasal(
    kimyasalkodu: int | None = None,
    kategori: str | None = None,
    kimyasaladi: str | None = None,
    birim: str | None = None,
    stokmiktari: float | None = None,
    depolokasyonu: str | None = None,
    minimumstok: int | None = None,
    tedarikci: str | None = None,
    sonkullanmatarihi: datetime | None = None,
    tehlikesinifi: str | None = None,
    db: Session = Depends(get_db)
):
    query = db.query(models.Kimyasal)
    query = active(query)

    if kimyasalkodu is not None:
        query = query.filter(models.Kimyasal.kimyasalkodu == kimyasalkodu)
    if kimyasaladi is not None:
        query = query.filter(
            models.Kimyasal.kimyasaladi.ilike(f"%{kimyasaladi}%")
        )
    if birim is not None:
        query = query.filter(
            models.Kimyasal.birim.ilike(f"%{birim}%")
        )
    if stokmiktari is not None:
        query = query.filter(
            models.Kimyasal.stokmiktari == stokmiktari
        )
    if depolokasyonu is not None:
        query = query.filter(
            models.Kimyasal.depolokasyonu.ilike(f"%{depolokasyonu}%")
        )
    if minimumstok is not None:
        query = query.filter(
            models.Kimyasal.minimumstok == minimumstok
        )
    if tedarikci is not None:
        query = query.filter(
            models.Kimyasal.tedarikci.ilike(f"%{tedarikci}%")
        )
    if sonkullanmatarihi is not None:
        query = query.filter(
            models.Kimyasal.sonkullanmatarihi == sonkullanmatarihi
        )
    if tehlikesinifi is not None:
        query = query.filter(
            models.Kimyasal.tehlikesinifi.ilike(f"%{tehlikesinifi}%")
        )
    if kategori is not None:
        query = query.filter(
            models.Kimyasal.kategori.ilike(f"%{kategori}%")
        )
    return query.all()