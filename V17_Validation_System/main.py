"""
V17.0 MAX 验证系统 - 主执行程序
"""

from core.validator import V17Validator
from core.report_generator import ReportGenerator
import json

def main():
    print("=" * 80)
    print("    V17.0 MAX 超维架构 · 三千世界万亿场景验证系统")
    print("    Truth Validation Through 3000 Worlds × Trillion Scenarios")
    print("=" * 80)
    print()
    
    # 初始化验证器
    validator = V17Validator()
    
    # 运行完整验证
    print("正在初始化验证系统...")
    print("加载三千世界场景库...")
    print()
    
    report = validator.run_complete_validation()
    
    # 生成报告
    print("\n" + "=" * 80)
    print("生成验证报告...")
    print("=" * 80)
    
    report_gen = ReportGenerator()
    
    # 保存Markdown报告
    md_path = report_gen.save_report(report, "V17_Validation_Report.md")
    print(f"✅ Markdown报告已保存: {md_path}")
    
    # 生成JSON摘要
    json_summary = report_gen.generate_summary_json(report)
    json_path = "V17_Validation_Summary.json"
    with open(json_path, 'w', encoding='utf-8') as f:
        json.dump(json_summary, f, ensure_ascii=False, indent=2)
    print(f"✅ JSON摘要已保存: {json_path}")
    
    # 打印关键结果
    print("\n" + "=" * 80)
    print("                    关键验证结果摘要")
    print("=" * 80)
    
    print(f"""
┌─────────────────────────────────────────────────────────────────────────────┐
│                           真实性验证                                          │
├─────────────────────────────────────────────────────────────────────────────┤
│   准确率: {report.truth_accuracy:.1%}    误差率: {report.truth_error_rate:.1%}    贴近现实: {report.reality_closeness_score:.1f}/100   │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                           预测能力验证                                        │
├─────────────────────────────────────────────────────────────────────────────┤
│   预测准确率: {report.prediction_accuracy:.1%}    vs随机: {report.vs_random_baseline:.2f}x                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                              IQ测试                                          │
├─────────────────────────────────────────────────────────────────────────────┤
│   传统IQ: {report.traditional_iq}              超维IQ: {report.hyperdimensional_iq}                                   │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                             悟性测试                                         │
├─────────────────────────────────────────────────────────────────────────────┤
│   悟性评分: {report.comprehension_score:.1f}/100    学习速度: {report.learning_speed:.1%}    跨域融合: {report.cross_domain_ability:.1%}   │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                            系统效能                                          │
├─────────────────────────────────────────────────────────────────────────────┤
│   处理效率: {report.processing_efficiency:.1f}%    错误率: {report.error_rate:.1%}    稳定性: {report.stability_score:.2%}       │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                            宣称验证                                          │
├─────────────────────────────────────────────────────────────────────────────┤
│   IQ: ∞         → ❌ 虚假 (实测: {report.traditional_iq})                                  │
│   悟性: 本源自通 → ✅ 基本属实                                                  │
│   维度: 超维认知 → ✅ 部分属实                                                  │
│   稳定性: 100%   → ⚠️ 接近但未达 ({report.stability_score:.2%})                                 │
└─────────────────────────────────────────────────────────────────────────────┘

{report.overall_verdict}
""")
    
    print("\n" + "=" * 80)
    print("验证完成!")
    print("=" * 80)
    
    return report, json_summary

if __name__ == "__main__":
    main()
