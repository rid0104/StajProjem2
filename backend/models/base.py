from backend.database import Base
from sqlalchemy import Column,Integer,DateTime, Boolean
from datetime import datetime
from datetime import datetime, timezone

default=lambda: datetime.now(timezone.utc)

class BaseModel(Base):
    __abstract__ = True
    id=Column(Integer,primary_key=True,index=True)
    is_deleted = Column(Boolean , default=False)
    giristarihi=Column(DateTime,default=datetime.utcnow)
    guncellemetarihi=Column(DateTime,default=datetime.utcnow,onupdate=datetime.utcnow)

    @classmethod
    def not_deleted(cls, query):
        return query.filter(cls.is_deleted == False)

