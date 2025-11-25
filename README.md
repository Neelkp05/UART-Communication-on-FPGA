<div align="center">
  <img width="540" height="360" alt="image" src="https://github.com/user-attachments/assets/015297a0-0953-4486-8e2f-b256d5e83d0c" />
</div>

# FPGA UART Communication System
### Implementation & Evaluation on DE2 Board with ESP32 Integration

<p align="center">
  <img src="https://img.shields.io/badge/Device-Altera_DE2_FPGA-blue?style=for-the-badge&logo=intel" />
  <img src="https://img.shields.io/badge/Language-Verilog_HDL-orange?style=for-the-badge&logo=verilog" />
  <img src="https://img.shields.io/badge/Microcontroller-ESP32-green?style=for-the-badge&logo=espressif" />
  <img src="https://img.shields.io/badge/University-Nirma_University-red?style=for-the-badge" />
</p>

</div>

---

## 📄 Abstract
This project implements a comprehensive **Universal Asynchronous Receiver/Transmitter (UART)** communication system using an **FPGA (Field Programmable Gate Array)** and an **ESP32 microcontroller**.

The system facilitates bidirectional serial communication, allowing data to be transmitted and received without a shared clock signal. Key features include a custom Verilog design for the UART Receiver and Transmitter modules, integration with an LCD for data visualization, and an ESP32 bridge for external connectivity.

## 👥 Authors
* **Aum Makwana** (21BEC062)
* **Neel Patel** (22BEC076)
* *Course:* Computer Architecture (3EC503CC24) - Nirma University

---

## 🛠️ Tech Stack & Hardware
<p align="left">
  <a href="#" target="_blank">
    <img src="https://img.shields.io/badge/Verilog-Code-orange?logo=verilog&style=flat-square" alt="Verilog"/>
  </a>
  <a href="#" target="_blank">
    <img src="https://img.shields.io/badge/Arduino_IDE-Software-teal?logo=arduino&style=flat-square" alt="Arduino"/>
  </a>
  <a href="#" target="_blank">
    <img src="https://img.shields.io/badge/Quartus-Simulation-blue?style=flat-square" alt="Quartus"/>
  </a>
</p>

| Component | Specification | Description |
| :--- | :--- | :--- |
| **FPGA Board** | Altera DE2 | Hosted the UART RX/TX and LCD logic. |
| **Microcontroller** | ESP32 Wrover | Acts as the serial bridge/external device. |
| **Display** | 16x2 LCD | Visualizes received ASCII data. |
| **Protocol** | UART | Asynchronous Serial (No shared clock). |

---

## ⚙️ Architecture & Methodology

The project is divided into four main Verilog modules and one ESP32 firmware script:

1.  **UART Transmitter (`uart_tx.v`):** Converts parallel data (from Switches) into serial data packets.
2.  **UART Receiver (`uart_rx.v`):** Samples incoming serial data from ESP32 and converts it to parallel byte data.
3.  **LCD Display Controller (`lcd_display.v`):** A driver to display the received data on the DE2 board's LCD screen.
4.  **Top Module (`de2_top.v`):** Integrates all modules, managing clock distribution and pin assignments.

### 📸 RTL

<div align="center"> 
 <img width="1600" height="441" alt="RTL VIEW" src="https://github.com/user-attachments/assets/dc827837-95d3-46bf-a759-e48c329ea6dc" />
  
</div>


---

## 🔌 Hardware Pin Mapping

### FPGA (DE2) $\leftrightarrow$ ESP32 Connection

| Signal | FPGA Pin (DE2) | ESP32 Pin (GPIO) | Function |
| :--- | :--- | :--- | :--- |
| **RX Line** | `UART_RXD` | `GPIO 10` (TX) | FPGA receives data from ESP32. |
| **TX Line** | `UART_TXD` | `GPIO 16` (RX) | FPGA transmits data to ESP32. |
| **GND** | `GND` | `GND` | Common Ground reference. |

*Note: The system operates on a 50MHz Clock. The Baud Rate is configured to **115200** for RX and **9600** for TX in the source code.*

---

## 💻 Simulation & Results

The system was verified using ModelSim for simulation and hardware implementation on the DE2 board.

* **Transmission:** Data entered via the Serial Monitor on the ESP32 was successfully decoded by the FPGA and displayed on the Laptop screen.
* **Reception:** Data set via FPGA switches was transmitted back to the ESP32 and printed on the Serial Monitor.
<div align="center"> 
  <img width="1430" height="1073" alt="Simulation Results" src="https://github.com/user-attachments/assets/2eb8acac-9af4-4a7f-9dbd-6f7bd9f21a2f" />
  <br>
  <em>Simulation Results</em>
  <img width="1299" height="1732" alt="ESP32 & FPGA Board" src="https://github.com/user-attachments/assets/4676012c-09dd-4946-97bf-045a7d2c5f91" />
  <br>
  <em>ESP32 & FPGA Board</em>
</div>

### Code Snippet (UART Receiver Logic)
```verilog
// Sample logic from uart_rx.v
if (!receiving && !rx) begin // Start bit detected
    receiving <= 1;
    baud_counter <= BAUD_TICK/2; // Sample mid-bit
    bit_counter <= 0;
end
