; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }

@xdp_stats_map = dso_local global %struct.bpf_map_def { i32 6, i32 4, i32 16, i32 5, i32 0 }, section "maps", align 4, !dbg !0
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !18
@llvm.used = appending global [3 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_stats1_func to i8*), i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_stats1_func(%struct.xdp_md* nocapture readonly %0) #0 section "xdp_stats1" !dbg !44 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !59, metadata !DIExpression()), !dbg !73
  %3 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !74
  %4 = load i32, i32* %3, align 4, !dbg !74, !tbaa !75
  call void @llvm.dbg.value(metadata i32 %4, metadata !60, metadata !DIExpression()), !dbg !73
  %5 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !80
  %6 = load i32, i32* %5, align 4, !dbg !80, !tbaa !81
  call void @llvm.dbg.value(metadata i32 %6, metadata !61, metadata !DIExpression()), !dbg !73
  %7 = bitcast i32* %2 to i8*, !dbg !82
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %7) #3, !dbg !82
  call void @llvm.dbg.value(metadata i32 2, metadata !71, metadata !DIExpression()), !dbg !73
  store i32 2, i32* %2, align 4, !dbg !83, !tbaa !84
  call void @llvm.dbg.value(metadata i64 undef, metadata !72, metadata !DIExpression()), !dbg !73
  call void @llvm.dbg.value(metadata i32* %2, metadata !71, metadata !DIExpression(DW_OP_deref)), !dbg !73
  %8 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @xdp_stats_map to i8*), i8* nonnull %7) #3, !dbg !85
  call void @llvm.dbg.value(metadata i8* %8, metadata !62, metadata !DIExpression()), !dbg !73
  %9 = icmp eq i8* %8, null, !dbg !86
  br i1 %9, label %19, label %10, !dbg !88

10:                                               ; preds = %1
  call void @llvm.dbg.value(metadata i8* %8, metadata !62, metadata !DIExpression()), !dbg !73
  %11 = zext i32 %4 to i64, !dbg !89
  call void @llvm.dbg.value(metadata i64 %11, metadata !60, metadata !DIExpression()), !dbg !73
  %12 = zext i32 %6 to i64, !dbg !90
  call void @llvm.dbg.value(metadata i64 %12, metadata !61, metadata !DIExpression()), !dbg !73
  %13 = sub nsw i64 %11, %12, !dbg !91
  call void @llvm.dbg.value(metadata i64 %13, metadata !72, metadata !DIExpression()), !dbg !73
  %14 = bitcast i8* %8 to i64*, !dbg !92
  %15 = atomicrmw add i64* %14, i64 1 seq_cst, !dbg !92
  %16 = getelementptr inbounds i8, i8* %8, i64 8, !dbg !93
  %17 = bitcast i8* %16 to i64*, !dbg !93
  %18 = atomicrmw add i64* %17, i64 %13 seq_cst, !dbg !93
  br label %19, !dbg !94

19:                                               ; preds = %1, %10
  %20 = phi i32 [ 2, %10 ], [ 0, %1 ], !dbg !73
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %7) #3, !dbg !95
  ret i32 %20, !dbg !95
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!40, !41, !42}
!llvm.ident = !{!43}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "xdp_stats_map", scope: !2, file: !3, line: 11, type: !32, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !17, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/mnt/d/xdp-tutorial/basic03-map-counter")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 2845, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "../headers/linux/bpf.h", directory: "/mnt/d/xdp-tutorial/basic03-map-counter")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0, isUnsigned: true)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1, isUnsigned: true)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2, isUnsigned: true)
!12 = !DIEnumerator(name: "XDP_TX", value: 3, isUnsigned: true)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4, isUnsigned: true)
!14 = !{!15, !16}
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!16 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!17 = !{!0, !18, !24}
!18 = !DIGlobalVariableExpression(var: !19, expr: !DIExpression())
!19 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 59, type: !20, isLocal: false, isDefinition: true)
!20 = !DICompositeType(tag: DW_TAG_array_type, baseType: !21, size: 32, elements: !22)
!21 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!22 = !{!23}
!23 = !DISubrange(count: 4)
!24 = !DIGlobalVariableExpression(var: !25, expr: !DIExpression())
!25 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !26, line: 33, type: !27, isLocal: true, isDefinition: true)
!26 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helper_defs.h", directory: "/mnt/d/xdp-tutorial/basic03-map-counter")
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!28 = !DISubroutineType(types: !29)
!29 = !{!15, !15, !30}
!30 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !31, size: 64)
!31 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!32 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map_def", file: !33, line: 33, size: 160, elements: !34)
!33 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helpers.h", directory: "/mnt/d/xdp-tutorial/basic03-map-counter")
!34 = !{!35, !36, !37, !38, !39}
!35 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !32, file: !33, line: 34, baseType: !7, size: 32)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !32, file: !33, line: 35, baseType: !7, size: 32, offset: 32)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !32, file: !33, line: 36, baseType: !7, size: 32, offset: 64)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !32, file: !33, line: 37, baseType: !7, size: 32, offset: 96)
!39 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !32, file: !33, line: 38, baseType: !7, size: 32, offset: 128)
!40 = !{i32 7, !"Dwarf Version", i32 4}
!41 = !{i32 2, !"Debug Info Version", i32 3}
!42 = !{i32 1, !"wchar_size", i32 4}
!43 = !{!"clang version 10.0.0-4ubuntu1 "}
!44 = distinct !DISubprogram(name: "xdp_stats1_func", scope: !3, file: !3, line: 26, type: !45, scopeLine: 27, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !58)
!45 = !DISubroutineType(types: !46)
!46 = !{!47, !48}
!47 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!48 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !49, size: 64)
!49 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 2856, size: 160, elements: !50)
!50 = !{!51, !54, !55, !56, !57}
!51 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !49, file: !6, line: 2857, baseType: !52, size: 32)
!52 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !53, line: 27, baseType: !7)
!53 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "")
!54 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !49, file: !6, line: 2858, baseType: !52, size: 32, offset: 32)
!55 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !49, file: !6, line: 2859, baseType: !52, size: 32, offset: 64)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !49, file: !6, line: 2861, baseType: !52, size: 32, offset: 96)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !49, file: !6, line: 2862, baseType: !52, size: 32, offset: 128)
!58 = !{!59, !60, !61, !62, !71, !72}
!59 = !DILocalVariable(name: "ctx", arg: 1, scope: !44, file: !3, line: 26, type: !48)
!60 = !DILocalVariable(name: "data_end", scope: !44, file: !3, line: 28, type: !15)
!61 = !DILocalVariable(name: "data", scope: !44, file: !3, line: 29, type: !15)
!62 = !DILocalVariable(name: "rec", scope: !44, file: !3, line: 30, type: !63)
!63 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !64, size: 64)
!64 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "datarec", file: !65, line: 8, size: 128, elements: !66)
!65 = !DIFile(filename: "./common_kern_user.h", directory: "/mnt/d/xdp-tutorial/basic03-map-counter")
!66 = !{!67, !70}
!67 = !DIDerivedType(tag: DW_TAG_member, name: "rx_packets", scope: !64, file: !65, line: 9, baseType: !68, size: 64)
!68 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !53, line: 31, baseType: !69)
!69 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "rx_bytes", scope: !64, file: !65, line: 10, baseType: !68, size: 64, offset: 64)
!71 = !DILocalVariable(name: "key", scope: !44, file: !3, line: 31, type: !52)
!72 = !DILocalVariable(name: "bytes", scope: !44, file: !3, line: 33, type: !68)
!73 = !DILocation(line: 0, scope: !44)
!74 = !DILocation(line: 28, column: 38, scope: !44)
!75 = !{!76, !77, i64 4}
!76 = !{!"xdp_md", !77, i64 0, !77, i64 4, !77, i64 8, !77, i64 12, !77, i64 16}
!77 = !{!"int", !78, i64 0}
!78 = !{!"omnipotent char", !79, i64 0}
!79 = !{!"Simple C/C++ TBAA"}
!80 = !DILocation(line: 29, column: 38, scope: !44)
!81 = !{!76, !77, i64 0}
!82 = !DILocation(line: 31, column: 2, scope: !44)
!83 = !DILocation(line: 31, column: 8, scope: !44)
!84 = !{!77, !77, i64 0}
!85 = !DILocation(line: 35, column: 8, scope: !44)
!86 = !DILocation(line: 40, column: 7, scope: !87)
!87 = distinct !DILexicalBlock(scope: !44, file: !3, line: 40, column: 6)
!88 = !DILocation(line: 40, column: 6, scope: !44)
!89 = !DILocation(line: 28, column: 27, scope: !44)
!90 = !DILocation(line: 29, column: 27, scope: !44)
!91 = !DILocation(line: 33, column: 25, scope: !44)
!92 = !DILocation(line: 46, column: 2, scope: !44)
!93 = !DILocation(line: 47, column: 2, scope: !44)
!94 = !DILocation(line: 56, column: 2, scope: !44)
!95 = !DILocation(line: 57, column: 1, scope: !44)
