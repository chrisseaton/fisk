# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VEXTRACTI128
    forms = []
    operands = []
    encodings = []
    # vextracti128: xmm, ymm, imm8
    operands << OPERAND_TYPES[26]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x39, 0
        add_modrm(buffer,
              3,
              operands[1].op_value,
              operands[0].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vextracti128: m128, ymm, imm8
    operands << OPERAND_TYPES[53]
    operands << OPERAND_TYPES[60]
    operands << OPERAND_TYPES[1]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_VEX buffer, operands
        add_opcode buffer, 0x39, 0
        add_modrm(buffer,
              0,
              operands[1].op_value,
              operands[0].op_value, operands)
        add_immediate buffer, operands[2].op_value, 1
      end

      def bytesize; 3; end
    }.new
    forms << Form.new(operands, encodings)
    VEXTRACTI128 = Instruction.new("VEXTRACTI128", forms)
  end
end
