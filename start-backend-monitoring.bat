
@echo off
title Project-04 Backend Metrics Port Forward
cd /d "C:\Users\HP 348 G7\OneDrive\Documents\GitHub\project4"
kubectl -n project4 port-forward service/blog-backend-service 5000:5000
pause
