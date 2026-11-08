from fastapi import APIRouter,Depends,HTTPException,status
from sqlalchemy.orm import Session
from backend.database import get_db
from backend import models
from backend.schemas.category import CategoryCreate,CategoryResponse
from fastapi.responses import Response


router = APIRouter(
    prefix="/category",
    tags=["Category"]
)
def active(query):
    """Soft delete uygulanmış kayıtları filtreler"""
    return query.filter(models.Kimyasal.is_deleted == False)

@router.post("/",response_model=CategoryResponse,status_code=status.HTTP_201_CREATED)
def create_category(item: CategoryCreate, db: Session = Depends(get_db)):
    mevcut_kategori = db.query(models.Category).filter(
        models.Category.name.ilike(item.name)).first()
    if mevcut_kategori:
        raise HTTPException(status_code=400,detail="kategori zaten mevcut")
    yeni_kategori= models.Category(
        name= item.name
    )
    db.add(yeni_kategori)
    db.commit()
    db.refresh(yeni_kategori)
    return yeni_kategori

@router.get("/", response_model=list[CategoryResponse])
def get_categories(db: Session = Depends(get_db), skip: int = 0, limit: int = 100):
    kategoriler = db.query(models.Category).filter(
        models.Category.is_deleted==False
    ).offset(skip).limit(limit).all()
    return kategoriler

@router.get("/{id}",response_model=CategoryResponse)
def get_category(id:int, db:Session = Depends(get_db)):
    kategori = db.query(models.Category).filter(
        models.Category.id ==id,
        models.Category.is_deleted ==False
    ).first()
    if not kategori:
        raise HTTPException(status_code=404, detail="kategori bulunamadı")
    return kategori
@router.put("/{id}", response_model=CategoryResponse)
def update_category(id:int, item: CategoryCreate, db: Session = Depends(get_db)):
    kategori = db.query(models.Category).filter(
        models.Category.id == id,
        models.Category.is_deleted ==False
    ).first()
    if not kategori:
        raise HTTPException(status_code=404, detail="kategori bulunamadi")
    kategori.name = item.name
    db.commit()
    db.refresh(kategori)
    return kategori
@router.delete("/{id}",status_code=status.HTTP_204_NO_CONTENT)
def delete_category(id: int, db: Session = Depends(get_db)):
    kategori = db.query(models.Category).filter(
        models.Category.id ==id,
        models.Category.is_deleted == False
    ).first()
    if not kategori:
        raise HTTPException(status_code=404, detail="kategori bulunamadi")
    kategori.is_deleted = True
    db.commit()
    return Response(status_code=204)
