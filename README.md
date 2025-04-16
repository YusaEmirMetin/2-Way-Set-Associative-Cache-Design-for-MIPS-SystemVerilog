# 2-Way Set-Associative Cache Design for MIPS – SystemVerilog

This project implements a 2-way set-associative cache memory for a 32-bit MIPS processor using SystemVerilog. The cache is simulated and tested using EDA Playground with a provided testbench.

## 📚 Course Information

- **Course**: CMPE 361 – Computer Organization  
- **Lab**: 3.3 – Cache Memory Design  
- **Instructor**: Saiful Islam  
- **Semester**: Fall 2024

## 🎯 Objective

Design and simulate a 2-way set-associative cache memory system that supports:
- Initialization via `reset`
- Hit/miss detection with LRU (Least Recently Used) replacement
- Outputting data from cache or main memory
- Updating cache blocks on miss

## 🧰 Tools & Technologies

- **Language**: SystemVerilog  
- **Simulator**: EDA Playground  
- **Target Architecture**: MIPS 32-bit  

## 🧱 Cache Architecture

- **Type**: 2-Way Set Associative  
- **Total Capacity**: 8 words  
- **Replacement Policy**: Least Recently Used (LRU)  
- **Main Memory Mapping**: `data = addr / 4`

## 🔧 Module Description

```systemverilog
module cache (
  input  logic [31:0] addr,
  input  logic        clk,
  input  logic        rst,
  output logic [31:0] out,
  output logic        hit
);
