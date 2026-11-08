
from sqlalchemy import  Float
from sqlalchemy import Column, Integer, DateTime ,String
from datetime import datetime
from .base import BaseModel

class Kimyasal(BaseModel):
    __tablename__="kimyasal"
    kimyasalkodu=Column(Integer,index=True)
    kimyasaladi=Column(String,index=True)
    kategori=Column(String,index=True)
    birim=Column(String,index=True)
    stokmiktari=Column(Float,index=True)
    minimumstok=Column(Integer,index=True)
    tedarikci=Column(String,index=True)
    tehlikesinifi=Column(String,index=True)
    depolokasyonu=Column(String,index=True)
    sonkullanmatarihi=Column(DateTime,default=datetime.utcnow)

