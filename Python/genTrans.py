import json
import datetime

def genItems(items, prices):
    aDict = dict()
    for item, price in zip(items, prices):
        aDict[item] = price
    return aDict, round(sum(prices), 2)

def genTrans(month, day, year, items, prices, store):
    aDict = dict()
    aDict["store"] = store
    dateTime = datetime.datetime(year, month, day)
    aDict["dateTime"] = dateTime.strftime('%m/%d/%Y')
    aDict["items"], aDict["total"] = genItems(items, prices)
    return aDict

def makeData():
    data, aList = dict(), list()
    aList.append(genTrans(8, 1, 2019, ['John Wick 3 IMAX ', 'Large Popcorn', 'Pepsi 500ml'], [21.00, 8.50, 5.00], 'Regal Theatre'))
    aList.append(genTrans(8, 1, 2019, ['Double Cheeseburger', 'Snack Wrap', 'Pepsi'], [3.99, 3.99 , 1.59], 'McDonalds'))
    aList.append(genTrans(8, 6, 2019, ['Beef & Broccoli'], [10.00], 'Panda Express'))
    aList.append(genTrans(8, 10, 2019, ['Q-Tips', 'Contact Lens Solution'], [5.67, 7.82], 'CVS Pharmarcy'))
    aList.append(genTrans(8, 14, 2019, ['Chilidog', 'Pepsi'], [4.99, 1.99], 'City Dogs'))
    aList.append(genTrans(8, 17, 2019, ['Chocolate Milkshake'], [8.00], 'Steak Shake'))
    aList.append(genTrans(8, 19, 2019, ['Happy Meal', 'Large Fries', 'Pepsi'], [5.00, 2.00 , 1.50], 'McDonalds'))
    aList.append(genTrans(8, 27, 2019, ['Beef & Broccoli', 'Orange Chicken'], [5.99, 5.99], 'Panda Express'))
    aList.append(genTrans(8, 30, 2019, ['Chips','Cookies'], [10.00,5.00], 'Walmart'))
    aList.append(genTrans(9, 1, 2019, ['CRSNT', 'ABC JASMINE RIC', 'PLUM TOMATOES', 'SB BTR LTTCEBLND'], [5.00, 8.50, 1.64, 2.69], 'Giant'))
    aList.append(genTrans(9, 2, 2019, ['Bread', 'Chips', 'Salsa'], [3.99, 2.99, 9.99], 'Chick-Fil-A'))
    aList.append(genTrans(9, 4, 2019, ['IT Chapter 2', 'Lrg Popcorn', 'Pepsi 500ml'], [14.00, 8.50, 5.00], 'Regal Theatre'))
    data["transactions"] = aList[::-1]
    return data

with open("./transactions.json", "w") as json_file:
    json.dump(makeData(),json_file, indent= 4)

def makedemo():
    data, aList = dict(), list()
    aList.append(genTrans(7, 7, 2019, ['DAN L&F PCH21.2Z', 'COL ANGL HAIR16Z'], [2.00, 3.29], 'Giant'))
    aList.append(genTrans(10, 11, 2019, ['INDOMIE FRIED ND', 'INDOMIE FRIED NDI'], [0.69, 0.69], 'Giant'))
    data["transactions"] = aList[::-1]
    return data

with open("./demo.json", "w") as json_file:
    json.dump(makedemo(), json_file, indent= 4)

