from pydantic import BaseModel, Field
from backend.core.enums import MovementType


class StokHareketCreate(BaseModel):
    entitytype: str
    entity_id: int
    harekettipi: MovementType
    miktar: float = Field(gt=0)
    aciklama: str | None = None


class StokHareketResponse(BaseModel):
    id: int
    entitytype: str
    entity_id: int
    harekettipi: MovementType
    miktar: float
    oncekistok: float
    sonrakistok: float
    aciklama: str | None

    class Config:
        from_attributes = True