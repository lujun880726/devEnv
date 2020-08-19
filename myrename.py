# coding:utf-8
import os
folder_path = '/Users/edz/Downloads/虚拟账号+图/男190个头像'
file_list = os.listdir(folder_path)
os.chdir(folder_path)
i = 1 
for old_name in file_list:
    (shotname,extension) = os.path.splitext(old_name)
    if extension != '.jpeg' and extension != '.png':
        continue
    new_name = str(i) + extension
    os.rename(old_name, new_name)
    i = i + 1
