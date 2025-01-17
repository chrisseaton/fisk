# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction VRSQRT28PD
    forms = []
    operands = []
    encodings = []
    # vrsqrt28pd: zmm{k}{z}, m512/m64bcst
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[64]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xCC, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # vrsqrt28pd: zmm{k}{z}, zmm, {sae}
    operands << OPERAND_TYPES[62]
    operands << OPERAND_TYPES[63]
    operands << OPERAND_TYPES[72]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_EVEX buffer, operands
        add_opcode buffer, 0xCC, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands)
      end

      def bytesize; 2; end
    }.new
    forms << Form.new(operands, encodings)
    VRSQRT28PD = Instruction.new("VRSQRT28PD", forms)
  end
end
