
from sqlalchemy import  Float

from sqlalchemy import Column, Integer, DateTime ,String

from .base import BaseModel
from sqlalchemy import Sequence

class Kumas(BaseModel):
    __tablename__="kumas"

    kumaskodu=Column(Integer,index=True)
    kumasadi=Column(String,index=True)
    kumastipi=Column(String,index=True)
    partino = Column(Integer, index=True)
    renk=Column(String,index=True)
    birim=Column(String,index=True)
    topsayisi=Column(Integer,index=True)
    stokmiktari=Column(Float,index=True)
    depolokasyonu=Column(String,index=True)
    durum=Column(String,index=True)


