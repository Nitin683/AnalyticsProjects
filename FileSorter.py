import os,shutil
path = r"E:/Riot Games/"
file_name = os.listdir(path)

folder_name = ['csv_files','image_files','mp3_files','txt_files','py_files','pdf_file']
for i in range(len(folder_name)):
    if not os.path.exists(path + folder_name[i]):
        os.makedirs(path+folder_name[i])

for file in file_name:
    file_path = os.path.join(path, file)

    if os.path.isdir(file_path):
        continue

    if file.endswith(('.csv', '.xlsx')):
        shutil.move(file_path, os.path.join(path, 'csv_files', file))
    elif file.endswith('.pdf'):
        shutil.move(file_path, os.path.join(path, 'pdf_file', file))
    elif file.endswith(('.png', '.jpg', '.jpeg')):
        shutil.move(file_path, os.path.join(path, 'image_files', file))
    elif file.endswith('.py'): 
        shutil.move(file_path, os.path.join(path, 'py_files', file))
    elif file.endswith(('.mp3', '.mp4')): 
        shutil.move(file_path, os.path.join(path, 'mp3_files', file))
    elif file.endswith(('.wrd', '.txt')):
        shutil.move(file_path, os.path.join(path, 'txt_files', file))