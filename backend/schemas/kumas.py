
from pydantic import BaseModel,Field,ConfigDict
from typing import Optional,List

from datetime import datetime

from pydantic import EmailStr

from backend.core.enums import MovementType

class BaseSchema(BaseModel):
    model_config=ConfigDict(from_attributes=True)
    
class KumasBase(BaseModel):
    kumaskodu:int
    kumasadi:str
    kumastipi:str
    renk:str
    birim:str
    topsayisi:int
    stokmiktari:float =Field(ge=0)
    depolokasyonu:str
    durum:str

 # model_config = {"from_attributes": True}

class KumasCreate(KumasBase):
    pass

class KumasResponse(KumasBase,BaseSchema):

    id: int

    is_deleted: bool

    giristarihi: datetime
    guncellemetarihi: datetime

    class Config:
        from_attributes = True