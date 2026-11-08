from fastapi import  APIRouter,FastAPI,Depends,HTTPException, status
#httpexception  kısmını ben yazmamıştım.statusta aynen
from datetime import datetime
from backend.core.enums import MovementType
from fastapi.responses import Response

from sqlalchemy.exc import IntegrityError

from sqlalchemy.orm import Session
from backend import models
from backend.database import create_table
from backend.database import get_db
from backend.schemas.kumas import KumasCreate,KumasResponse,KumasBase

from contextlib import asynccontextmanager


router  = APIRouter(
   prefix="/kumas",
   tags=["Kumas"]
)



def active(query):
    """Soft delete uygulanmış kayıtları filtreler"""
    return query.filter(models.Kumas.is_deleted == False)




@router.post("/")
def create_kumas(item: KumasCreate, db: Session = Depends(get_db)):
    try:
        data = item.model_dump(exclude={"partino"})  # <-- KRİTİK
        yeni_urun = models.Kumas(**data)

        db.add(yeni_urun)
        db.commit()
        db.refresh(yeni_urun)

        return yeni_urun

    except IntegrityError:
        db.rollback()
        raise HTTPException(
            status_code=400,
            detail="Duplicate partino veya unique alan hatası"
        )




@router.get("/", response_model=list[KumasResponse])
def get_kumas(db:Session =Depends(get_db), skip:int=0, limit:int=10):
    result= (
         db.query(models.Kumas)
         .filter(models.Kumas.is_deleted == False)
         .offset(skip)
         .limit(limit)
         .all()
    )
    return result




@router.put("/{id}",response_model=KumasResponse)
def update_kumas(id:int,item:KumasCreate,db:Session =Depends(get_db)):
    query=db.query(models.Kumas).filter(models.Kumas.id==id)
    db_item=query.first()

    if not db_item:
       raise HTTPException(status_code=404,detail="bulunamadı")

   # query.update(item.model_dump(),synchronize_session=False)
    
    for key,value in item.model_dump(exclude_unset=True).items():
     if key != "id" :
         setattr(db_item,key,value) #burasının böyle kullanılması daha güvenliymiş
    
    
    db.commit()  #tek tek girmke yerine aşağıdaki versiyon kullanılıyor...
    db.refresh(db_item)
    return db_item




@router.delete("/{id}",status_code=status.HTTP_204_NO_CONTENT)
def del_kumas(id:int,db:Session=Depends(get_db)):
   db_item=db.query(models.Kumas).filter(models.Kumas.id==id).first()
   if not db_item:
      raise HTTPException(status_code=404,detail="ürün bulunamadı")
    
   db_item.is_deleted = True
   db.commit()

   return Response(status_code=204)




@router.get("/search",response_model=list[KumasResponse])
def search_kumas(
    partino:int | None = None,
    kumaskodu:int | None = None,
    kumasadi:str | None = None,
    kumastipi:str | None = None,
    renk:str | None = None,
    birim:str | None = None,
    topsayisi:int | None = None,
    stokmiktari:float  | None = None,
    depolokasyonu:str | None = None,
    durum:str  | None = None,
    db: Session = Depends(get_db)
):
    
    
    query=db.query(models.Kumas)
    query = active(query)
    if partino is not None:
        query=query.filter(models.Kumas.partino==partino)
    if kumaskodu  is not None:
        query=query.filter(models.Kumas.kumaskodu==kumaskodu)
    if kumasadi  is not None:
        query=query.filter(models.Kumas.kumasadi.ilike(f"%{kumasadi}%"))
    if kumastipi  is not None:
        query=query.filter(models.Kumas.kumastipi.ilike(f"%{kumastipi}%"))
    if renk  is not None:
        query=query.filter(models.Kumas.renk.ilike(f"%{renk}%"))
    if birim  is not None:
        query=query.filter(models.Kumas.birim.ilike(f"%{birim}%"))
    if topsayisi  is not None:
        query=query.filter(models.Kumas.topsayisi==topsayisi)
    if stokmiktari  is not None:
        query=query.filter(models.Kumas.stokmiktari==stokmiktari)
    if depolokasyonu  is not None:
        query=query.filter(models.Kumas.depolokasyonu.ilike(f"%{depolokasyonu}%"))
    if durum  is not None:
        query=query.filter(models.Kumas.durum.ilike(f"%{durum}%"))



    return query.all()
    