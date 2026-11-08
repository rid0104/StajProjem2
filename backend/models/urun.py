
from backend.core.enums import MovementType
from sqlalchemy import ForeignKey, Float
from sqlalchemy.orm import relationship
from sqlalchemy import Column, Integer, DateTime ,String
from datetime import datetime
from sqlalchemy import Enum as SqlEnum
from .base import BaseModel


class Urun(BaseModel):
    __tablename__="urunler"
    uruntipi=Column(String,index=True)
    birim=Column(String,index=True)
    minimumstok=Column(Integer)
    miktar=Column(Float,index=True)
    aciklama=Column(String)
    partino=Column(Integer,index=True)
    
