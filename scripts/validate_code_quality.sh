#!/bin/bash
# validate_code_quality.sh
# Script de validación de calidad de código para el Design System
# Uso: ./scripts/validate_code_quality.sh

set -e

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║     Validación de Calidad de Código - Design System            ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Contadores
PHASE1_OK=true
PHASE2_OK=true
PHASE4_OK=true

# ============================================
# FASE 1: Issues Críticos
# ============================================
echo "┌────────────────────────────────────────────────────────────────┐"
echo "│ FASE 1: Verificando issues críticos...                        │"
echo "└────────────────────────────────────────────────────────────────┘"

# avoid_dynamic_calls
DYNAMIC=$(flutter analyze 2>&1 | grep -c "avoid_dynamic_calls" || echo "0")
if [ "$DYNAMIC" -eq 0 ]; then
  echo -e "  ${GREEN}✅${NC} avoid_dynamic_calls: 0 issues"
else
  echo -e "  ${RED}❌${NC} avoid_dynamic_calls: $DYNAMIC issues"
  PHASE1_OK=false
fi

# avoid_catches_without_on_clauses
CATCH=$(flutter analyze 2>&1 | grep -c "avoid_catches_without_on_clauses" || echo "0")
if [ "$CATCH" -eq 0 ]; then
  echo -e "  ${GREEN}✅${NC} avoid_catches_without_on_clauses: 0 issues"
else
  echo -e "  ${RED}❌${NC} avoid_catches_without_on_clauses: $CATCH issues"
  PHASE1_OK=false
fi

echo ""

# ============================================
# FASE 2: Documentación
# ============================================
echo "┌────────────────────────────────────────────────────────────────┐"
echo "│ FASE 2: Verificando documentación en lib/...                  │"
echo "└────────────────────────────────────────────────────────────────┘"

DOCS=$(flutter analyze 2>&1 | grep "lib/src/" | grep -c "public_member_api_docs" || echo "0")
if [ "$DOCS" -eq 0 ]; then
  echo -e "  ${GREEN}✅${NC} public_member_api_docs: 0 issues en lib/"
else
  echo -e "  ${YELLOW}⚠️${NC}  public_member_api_docs: $DOCS issues pendientes"
  PHASE2_OK=false
fi

echo ""

# ============================================
# FASE 4: Tests
# ============================================
echo "┌────────────────────────────────────────────────────────────────┐"
echo "│ FASE 4: Verificando issues en tests...                        │"
echo "└────────────────────────────────────────────────────────────────┘"

TEST_ISSUES=$(flutter analyze 2>&1 | grep "test/" | grep -c "info •\|warning •\|error •" || echo "0")
if [ "$TEST_ISSUES" -eq 0 ]; then
  echo -e "  ${GREEN}✅${NC} Issues en test/: 0"
else
  echo -e "  ${YELLOW}⚠️${NC}  Issues en test/: $TEST_ISSUES"
  PHASE4_OK=false
fi

echo ""

# ============================================
# TESTS
# ============================================
echo "┌────────────────────────────────────────────────────────────────┐"
echo "│ Ejecutando tests...                                           │"
echo "└────────────────────────────────────────────────────────────────┘"

TEST_OUTPUT=$(flutter test 2>&1)
if echo "$TEST_OUTPUT" | grep -q "All tests passed"; then
  PASSED_COUNT=$(echo "$TEST_OUTPUT" | grep -oE "\+[0-9]+" | tail -1 | tr -d '+')
  echo -e "  ${GREEN}✅${NC} All tests passed ($PASSED_COUNT tests)"
elif echo "$TEST_OUTPUT" | grep -q "Some tests failed"; then
  FAILED_INFO=$(echo "$TEST_OUTPUT" | grep -oE "\+[0-9]+ -[0-9]+" | tail -1)
  echo -e "  ${RED}❌${NC} Some tests failed ($FAILED_INFO)"
else
  echo -e "  ${YELLOW}⚠️${NC}  Tests ejecutados (verificar salida manualmente)"
fi

echo ""

# ============================================
# RESUMEN TOTAL
# ============================================
TOTAL_ISSUES=$(flutter analyze 2>&1 | grep -c "info •\|warning •\|error •" || echo "0")

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                         RESUMEN                                ║"
echo "╠════════════════════════════════════════════════════════════════╣"

if [ "$PHASE1_OK" = true ]; then
  echo -e "║  ${GREEN}✅${NC} Fase 1 (Crítica):      COMPLETA                           ║"
else
  echo -e "║  ${RED}❌${NC} Fase 1 (Crítica):      PENDIENTE                          ║"
fi

if [ "$PHASE2_OK" = true ]; then
  echo -e "║  ${GREEN}✅${NC} Fase 2 (Documentación): COMPLETA                          ║"
else
  echo -e "║  ${YELLOW}⚠️${NC}  Fase 2 (Documentación): $DOCS pendientes                    ║"
fi

echo "║  ── Fase 3 (Rendimiento): OPCIONAL                            ║"

if [ "$PHASE4_OK" = true ]; then
  echo -e "║  ${GREEN}✅${NC} Fase 4 (Tests):        COMPLETA                           ║"
else
  echo -e "║  ${YELLOW}⚠️${NC}  Fase 4 (Tests):        $TEST_ISSUES pendientes                    ║"
fi

echo "╠════════════════════════════════════════════════════════════════╣"
echo "║  Total Issues: $TOTAL_ISSUES                                            ║"
echo "╚════════════════════════════════════════════════════════════════╝"

# Exit code
if [ "$PHASE1_OK" = true ] && [ "$PHASE2_OK" = true ] && [ "$PHASE4_OK" = true ]; then
  echo ""
  echo -e "${GREEN}✅ Todas las fases completadas exitosamente${NC}"
  exit 0
else
  echo ""
  echo -e "${YELLOW}⚠️  Hay fases pendientes de completar${NC}"
  exit 1
fi
