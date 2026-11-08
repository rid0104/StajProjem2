from fastapi import FastAPI
from backend.database import create_table
from backend.routers import kimyasal
from backend.routers import urun
from backend.routers import auth
from backend.routers import category
from backend.routers import kumas
from backend.routers import stokhareket
from fastapi import Request
from fastapi.responses import JSONResponse
from contextlib import asynccontextmanager
from fastapi.middleware.cors import CORSMiddleware
import sys
import os

sys.path.append(os.path.dirname(os.path.abspath(__file__)))

@asynccontextmanager

async def lifespan(app: FastAPI):
    create_table ()
    yield

app = FastAPI(lifespan=lifespan)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)
app.include_router(stokhareket.router)
app.include_router(kumas.router)
app.include_router(kimyasal.router)
app.include_router(urun.router)
app.include_router(auth.router)
app.include_router(category.router)

@app.exception_handler(Exception)
async def global_excetion_handler(
    request: Request,
    exc: Exception
):
    return JSONResponse(
        status_code=500,
        content={
            "success" : False,
            "message" :"sunucu hatasi"
        }
    )


