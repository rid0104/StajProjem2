from sqlalchemy import Column,String
from .base import BaseModel
from sqlalchemy.orm import relationship

class User(BaseModel):
    __tablename__="users"
  
    email = Column(String,unique=True,nullable=False)
    kullaniciadi = Column(String,unique=True,nullable=False)
    hashed_password=Column(String,nullable=False)

    
