# Term project in TFE4171
by
Eivind Gamst and Øystein Smith

###The files added in the term project are:
* **/trunk/code/top/tb/hdlc_packet.sv**           - Test bench data class
* **/trunk/code/top/tb/hdlc_tb.sv**               - Test bench
* **/trunk/code/top/tb/tb_wrapper.v**             - Test bench wrapper
* **/trunk/code/top/scripts/sva/hdlc_props.v**    - Assertions


### The report is found in the repository root in two different formats:
* **TFE4171_Semester_Project.pdf**                - For printing
* **TFE4171_Term_Project_noprint.pdf**            - For digital reading

## Preface
This report describes the work done in the term project in the subject TFE4171 Design of Digital Systems 2 spring of 2016. This project was cancelled one week before the deadline, and this report is heavily influenced by this. This report is written after the cancellation of the project to document the work done on the project, because the authors felt a lot of work has been put into the project and did not want it to go to waste. This report is to be regarded as a first draft, and not a complete work.

When reading the methodology chapter \cref{method} it is recommended to keep the source code appended side by side to quicly reference it.

## Abstract
In this report an untested  HDLC module will be verified with the usage of SystemVerilog Assertions and constrained random stimuli.

The language for verifying the HDLC module was chosen as system verilog (SV). System verilog assertions (SVA) was used to verify the output. The input is generated with constrained randomisation.

The assertions were written from the specification in \cite{hdlc_core}, although it was lacking in parts describing the protocol of hdlc were the hdlc standart was used to specify correct behaviour \cite{ISO13239}. But these two specifiactions were not completely covering, so when an assertion failed where these specifications were not absolute it was assumed that the authors guesswork was at fault and the hdlc module was functioning properly, and such the assertions were rewritten as to pass. This is a large error source, wich can be improved by a better specification, and/or more experienced authors.

As the work on implementing the testbench and subsequent revisions of the assertions was not completed, no conclusions as to the correct behaviour of the hdlc module can be made. The implementation of the testbench, data generation, and validation by assertions seems to be on the right track but not completed.