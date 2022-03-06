//
//  BluetoothViewController.swift
//  iOSerBuilding
//
//  Created by 张海川 on 2022/3/6.
//

import UIKit
import CoreBluetooth

class BluetoothViewController: UIViewController {
    
    var myCentral: CBCentralManager!
    
    var myPeripheral: CBPeripheral!
    
    var dataInCharacteristic: CBCharacteristic!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myCentral = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        
        let button = UIButton(type: .system).then {
            $0.setTitle("Button", for: .normal)
            $0.frame = CGRect(x: 44, y: 100, width: 68, height: 30)
            $0.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        }
        view.addSubview(button)
    }
    
    @objc func buttonClicked() {
        let data = NSData(fromHexString: "00228edbb94f29ce7ba052b60b703f523b88dae17e78f4cf0d") as Data
        myPeripheral.writeValue(data, for: dataInCharacteristic, type: .withoutResponse)
    }

}

extension BluetoothViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        guard central.state == .poweredOn else { return }
        central.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard peripheral.name == "GenieLight" else {
            return
        }
        myPeripheral = peripheral
        myCentral.connect(peripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        myCentral.stopScan()
        myPeripheral.delegate = self
        myPeripheral.discoverServices([CBUUID(string: "1828")])
    }
}

extension BluetoothViewController: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        let service = peripheral.services!.first!
        peripheral.discoverCharacteristics([CBUUID(string: "2ADD")], for: service)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        dataInCharacteristic = service.characteristics!.first!
        
//        peripheral.readValue(for: myCharacteristic)
//        peripheral.setNotifyValue(true, for: myCharacteristic)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil {
            print("订阅失败")
        } else if characteristic.isNotifying {
            print("订阅成功")
        } else {
            print("取消订阅")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard error == nil else {
            return
        }
//        let data = characteristic.value!
//        let str = String(data: data, encoding: .utf8)
//        print(str)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        
    }
}

