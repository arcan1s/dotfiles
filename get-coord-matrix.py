#!/usr/bin/python2

import commands, sys


def get_resolutions():
    resolutions = []
    xrandr_output = commands.getoutput("xrandr")
    # total
    total = xrandr_output.split('\n')[0]
    resolutions += [[float(total.split(', ')[1].split()[1]), float(total.split(', ')[1].split()[3])]]
    for line in xrandr_output.split('\n'):
        if (line.find('*') == -1): continue
        resolutions += [[float(line.split()[0].split('x')[0]), float(line.split()[0].split('x')[1])]]
    return resolutions


def get_matrix(resolutions, second = "leftof"):
    if (len(resolutions) == 2):
        c0 = 1.0
        c1 = 0.0
        c2 = 1.0
        c3 = 0.0
    elif (second == "leftof"):
        c0 = resolutions[1][0] / resolutions[0][0]
        c1 = resolutions[2][0] / resolutions[0][0]
        c2 = resolutions[1][1] / resolutions[0][1]
        c3 = 0.0
    elif (second == "rightof") or (second == "below"):
        c0 = resolutions[1][0] / resolutions[0][0]
        c1 = 0.0
        c2 = resolutions[1][1] / resolutions[0][1]
        c3 = 0.0
    elif (second == "above"):
        c0 = resolutions[1][0] / resolutions[0][0]
        c1 = 0.0
        c2 = resolutions[1][1] / resolutions[0][1]
        c3 = resolutions[2][1] / resolutions[0][1]
    return "%f 0.0 %f 0.0 %f %f 0.0 0.0 1.0" %(c0, c1, c2, c3)

if __name__ == "__main__":
    state = "leftof"
    if (len(sys.argv) > 1):
        if sys.argv[1] in ["leftof", 'rightof', "below", "above"]:
            state = sys.argv[1]
    resolutions = get_resolutions()
    print(get_matrix(resolutions, state))

