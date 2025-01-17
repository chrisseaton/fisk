# frozen_string_literal: true

class Fisk
  module Instructions
    # Instruction PF2ID
    forms = []
    operands = []
    encodings = []
    # pf2id: mm, mm
    operands << OPERAND_TYPES[35]
    operands << OPERAND_TYPES[36]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              0,
              operands[1].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x0F, 0
        add_modrm(buffer,
              3,
              operands[0].op_value,
              operands[1].op_value, operands)
        add_opcode buffer, 0x1D, 0
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    operands = []
    encodings = []
    # pf2id: mm, m64
    operands << OPERAND_TYPES[35]
    operands << OPERAND_TYPES[18]
    encodings << Class.new(Fisk::Encoding) {
      def encode buffer, operands
        add_rex(buffer, operands,
              false,
              0,
              operands[0].rex_value,
              operands[1].rex_value,
              operands[1].rex_value)
        add_opcode buffer, 0x0F, 0
        add_opcode buffer, 0x0F, 0
        add_modrm(buffer,
              0,
              operands[0].op_value,
              operands[1].op_value, operands)
        add_opcode buffer, 0x1D, 0
      end

      def bytesize; 4; end
    }.new
    forms << Form.new(operands, encodings)
    PF2ID = Instruction.new("PF2ID", forms)
  end
end
