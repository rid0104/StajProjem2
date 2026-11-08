
from backend.database import Base
from sqlalchemy.orm import relationship
from sqlalchemy import Column, String

from .base import BaseModel

class Category(BaseModel):
    __tablename__="categories"
    name=Column(String,unique=True)
