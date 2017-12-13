import subprocess
import time
import os

proc = subprocess.Popen(['ssh','-Y', 'toor@192.168.186.139'],
                        stdout=subprocess.PIPE,
                        stderr=subprocess.PIPE)

step = 0

results = []
while True:
    line_b = proc.stdout.readline()
    line = line_b.decode("utf-8").strip().replace('\r\n', '')
    print(line, end='\r\n', flush=True)
    if line == '0/100':
        start_time = time.time()
    if line == '100/100':
        end_time = time.time()
        print(start_time, end_time, end_time - start_time)
        results.append(end_time - start_time)
        if len(results) % 3 == 0:
            for i in range(len(results) // 3):
                print(', '.join([str(f) for f in results[i * 3:i * 3 + 3]]) + '\r\n')

    #the real code does filtering here
    # print("test: ")#, line.decode("utf-8").strip())
    # print(line)
    # if line.endswith('updates.'):
    #     print('step 0')
    #     proc.stdin.write('cd /home/toor/6.828/cpsc508 && echo 1\n'.encode('utf-8'))
    #     proc.stdin.flush()
    #     step += 1
    #     continue
    # if step == 1 and line == '1':
    #     print('step 1')
    #     proc.stdin.write('pwd\n'.encode('utf-8'))
    #     proc.stdin.flush()
    #     step += 1
    #     continue
    # if step == 2 and 'cpsc' in line:
    #     print('step 2')
    #     proc.stdin.write('make qemu-nox\n'.encode('utf-8'))
    #     proc.stdin.flush()
    #     step += 1
    #     continue
    # if step == 3 and 'starting sh' in line:
    #     print('step 3')
    #     proc.stdin.write('\ntest_mmap\n'.encode('utf-8'))
    #     proc.stdin.flush()
    #     step += 1
    #     continue
    # if step == 4:
    #     proc.stdin.write('^Ax'.encode('utf-8'))
    #     proc.stdin.flush()
    #     step += 1
    #     continue