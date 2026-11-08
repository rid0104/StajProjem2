from fastapi import  APIRouter,FastAPI,Depends,HTTPException, status
#httpexception  kısmını ben yazmamıştım.statusta aynen
from datetime import datetime
from backend.core.enums import MovementType
from fastapi.responses import Response
from typing import Optional, List
from backend.database import create_table
from backend.database import get_db
from sqlalchemy.orm import Session

import backend.models as models

from backend.schemas.urun import UrunBase,UrunCreate,UrunResponse

from contextlib import asynccontextmanager

router  = APIRouter(
   prefix="/urun",
   tags=["Urun"]
)

def active(query):
    """Soft delete uygulanmış kayıtları filtreler"""
    return query.filter(models.Urun.is_deleted == False)


@router.post("/",response_model=UrunResponse,status_code=status.HTTP_201_CREATED)
def create_urun(item:UrunBase, db:Session =Depends(get_db)):
    yeni_urun = models.Urun(**item.model_dump())
    db.add(yeni_urun)
    db.commit()
    db.refresh(yeni_urun)
    return  yeni_urun


@router.get("/", response_model=list[UrunResponse])
def get_urun(db:Session =Depends(get_db), skip:int=0, limit:int=10):
    result= (
        db.query(models.Urun)
        .filter(models.Urun.is_deleted == False)
        .offset(skip)
        .limit(limit)
        .all()
    )
    return result


@router.put("/{id}",response_model=UrunResponse)
def update_urun(id:int,item:UrunCreate,db:Session =Depends(get_db)):
    query=db.query(models.Urun).filter(models.Urun.id==id)
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
def del_urun(id:int,db:Session=Depends(get_db)):
   db_item=db.query(models.Urun).filter(models.Urun.id==id).first()
   if not db_item:
      raise HTTPException(status_code=404,detail="ürün bulunamadı")
    
   
   db_item.is_deleted = True
   db.commit()
   return Response(status_code=204)





@router.get("/search",response_model=list[UrunResponse])
def search_urun(

    uruntipi: str|None=None,
    birim:str | None = None,
    miktar:float| None = None,

    minimumstok:int |None=None,
    aciklama:str =None,
    partino:int | None=None,


    db: Session = Depends(get_db)
):
    query=db.query(models.Urun)
    query=active(query)
 
    if partino  is not None: 
        query=query.filter(models.Urun.partino==partino)
    if birim  is not None:
        query=query.filter(models.Urun.birim==birim)
    if minimumstok  is not None:
         query=query.filter(models.Urun.minimumstok==minimumstok)
    if uruntipi  is not None:
         query=query.filter(models.Urun.uruntipi.ilike(f"%{uruntipi}%"))

    if miktar  is not None:
         query=query.filter(models.Urun.miktar==miktar)

    if aciklama  is not None:
        query=query.filter(models.Urun.aciklama.ilike(f"%{aciklama}%"))
    
    query = models.Urun.not_deleted(query)
    return query.all()


