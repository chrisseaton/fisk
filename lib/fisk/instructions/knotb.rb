# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction KNOTB
    forms = []
    operands = []
    encodings = []
    # knotb: k, k
    operands << OPERAND_TYPES[41]
    operands << OPERAND_TYPES[42]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x44, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    KNOTB = Instruction.new("KNOTB", forms)
  end
end
