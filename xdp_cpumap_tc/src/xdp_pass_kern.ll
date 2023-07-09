; ModuleID = 'xdp_pass_kern.c'
source_filename = "xdp_pass_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.xdp_md = type { i32, i32, i32, i32, i32 }

@llvm.used = appending global [1 x i8*] [i8* bitcast (i32 (%struct.xdp_md*)* @xdp_prog to i8*)], section "llvm.metadata"

; Function Attrs: norecurse nounwind readnone
define dso_local i32 @xdp_prog(%struct.xdp_md* nocapture readnone %0) #0 section "xdp" !dbg !16 {
  call void @llvm.dbg.value(metadata %struct.xdp_md* undef, metadata !31, metadata !DIExpression()), !dbg !32
  ret i32 2, !dbg !33
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { norecurse nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!12, !13, !14}
!llvm.ident = !{!15}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "xdp_pass_kern.c", directory: "/home/asteria/xdp/xdp_cpumap_tc/src")
!2 = !{!3}
!3 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !4, line: 3151, baseType: !5, size: 32, elements: !6)
!4 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "")
!5 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!6 = !{!7, !8, !9, !10, !11}
!7 = !DIEnumerator(name: "XDP_ABORTED", value: 0, isUnsigned: true)
!8 = !DIEnumerator(name: "XDP_DROP", value: 1, isUnsigned: true)
!9 = !DIEnumerator(name: "XDP_PASS", value: 2, isUnsigned: true)
!10 = !DIEnumerator(name: "XDP_TX", value: 3, isUnsigned: true)
!11 = !DIEnumerator(name: "XDP_REDIRECT", value: 4, isUnsigned: true)
!12 = !{i32 7, !"Dwarf Version", i32 4}
!13 = !{i32 2, !"Debug Info Version", i32 3}
!14 = !{i32 1, !"wchar_size", i32 4}
!15 = !{!"clang version 10.0.0-4ubuntu1 "}
!16 = distinct !DISubprogram(name: "xdp_prog", scope: !1, file: !1, line: 6, type: !17, scopeLine: 7, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !30)
!17 = !DISubroutineType(types: !18)
!18 = !{!19, !20}
!19 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !4, line: 3162, size: 160, elements: !22)
!22 = !{!23, !26, !27, !28, !29}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !21, file: !4, line: 3163, baseType: !24, size: 32)
!24 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !25, line: 27, baseType: !5)
!25 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!26 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !21, file: !4, line: 3164, baseType: !24, size: 32, offset: 32)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !21, file: !4, line: 3165, baseType: !24, size: 32, offset: 64)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !21, file: !4, line: 3167, baseType: !24, size: 32, offset: 96)
!29 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !21, file: !4, line: 3168, baseType: !24, size: 32, offset: 128)
!30 = !{!31}
!31 = !DILocalVariable(name: "ctx", arg: 1, scope: !16, file: !1, line: 6, type: !20)
!32 = !DILocation(line: 0, scope: !16)
!33 = !DILocation(line: 8, column: 2, scope: !16)
