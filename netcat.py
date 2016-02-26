import socket

def netcat(hostname, port, content):
    buf = ''
    s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    s.settimeout(5)
    s.connect((hostname, port))
    s.sendall(content)
    s.shutdown(socket.SHUT_WR)
    while 1:
        data = s.recv(1024)
        if data == "":
            break
        buf += data
        print "Received:",repr(data)
    print "connection closed"
    s.close()
    return buf;
