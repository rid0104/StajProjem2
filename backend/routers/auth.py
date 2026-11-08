from sqlalchemy.orm import Session
from fastapi import Depends, HTTPException, status, APIRouter
from backend import models
from backend.database import get_db
from backend.core.security import (
    hash_password,
    verify_password,
    create_access_token,
)

from backend.schemas.user import UserCreate, LoginRequest
from backend.schemas.token import Token

router = APIRouter(
    prefix="/auth",
    tags=["Authentication"]
)


@router.post("/register", status_code=status.HTTP_201_CREATED)
def register(
    user_in: UserCreate,
    db: Session = Depends(get_db)
):
    db_user = db.query(models.User).filter(
        (models.User.email == user_in.email) |
        (models.User.kullaniciadi == user_in.kullaniciadi)
    ).first()

    if db_user:
        raise HTTPException(
            status_code=400,
            detail="Email veya kullanıcı adı zaten kullanımda"
        )

    hashed_pw = hash_password(user_in.password)

    new_user = models.User(
        email=user_in.email,
        kullaniciadi=user_in.kullaniciadi,
        hashed_password=hashed_pw
    )

    db.add(new_user)
    db.commit()

    return {
        "message": "Kullanıcı başarıyla oluşturuldu"
    }


@router.post("/login", response_model=Token)
def login(
    data: LoginRequest,
    db: Session = Depends(get_db)
):
    user = db.query(models.User).filter(
        models.User.kullaniciadi == data.username
    ).first()

    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Hatalı kullanıcı adı veya şifre"
        )

    if not verify_password(
        data.password,
        user.hashed_password
    ):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Hatalı kullanıcı adı veya şifre"
        )

    access_token = create_access_token(
        data={
            "sub": user.kullaniciadi,
            "uid": user.id
        }
    )

    return {
        "access_token": access_token,
        "token_type": "bearer"
    }