# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction KORTESTD
    forms = []
    operands = []
    encodings = []
    # kortestd: k, k
    operands << OPERAND_TYPES[42]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x98, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    KORTESTD = Instruction.new("KORTESTD", forms)
  end
end
