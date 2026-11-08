
from pydantic import BaseModel,Field,ConfigDict


from datetime import datetime

from backend.core.enums import MovementType

class BaseSchema(BaseModel):
    model_config=ConfigDict(from_attributes=True)

class UrunBase(BaseModel):
    uruntipi:str = Field(min_length=2, max_length=100)
    birim:str
    miktar:float=Field(default=0,ge=0)
    minimumstok:int=Field(default=0)
    aciklama:str =None
    partino:int


  
   
 # model_config = {"from_attributes": True}

class UrunCreate(UrunBase):
    pass

class UrunResponse(UrunBase,BaseSchema):

    id: int

    is_deleted: bool

    giristarihi: datetime
    guncellemetarihi: datetime

    class Config:
        from_attributes = True