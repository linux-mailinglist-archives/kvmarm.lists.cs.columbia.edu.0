Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D21ED61D871
	for <lists+kvmarm@lfdr.de>; Sat,  5 Nov 2022 08:24:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 516374B133;
	Sat,  5 Nov 2022 03:24:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linaro.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TcZUQ00O7y8Q; Sat,  5 Nov 2022 03:24:00 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 05E8F40162;
	Sat,  5 Nov 2022 03:23:59 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C183748FA4
 for <kvmarm@lists.cs.columbia.edu>; Sat,  5 Nov 2022 03:23:57 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Z9VNL+n9UsT for <kvmarm@lists.cs.columbia.edu>;
 Sat,  5 Nov 2022 03:23:55 -0400 (EDT)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4063A4A1D9
 for <kvmarm@lists.cs.columbia.edu>; Sat,  5 Nov 2022 03:23:55 -0400 (EDT)
Received: by mail-pj1-f41.google.com with SMTP id o7so6356866pjj.1
 for <kvmarm@lists.cs.columbia.edu>; Sat, 05 Nov 2022 00:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8CxQ8M2QM9sBIlwmPDF3sO4KY64cCnbt7okAkRcIdI=;
 b=c0dlly7hwTw7JU56MQSd2/9OjXdPEB8Z/l2dmasIIKMvsyZHc8sBbN5UJQtR7mVC09
 q1RR61V+SDTO2DuU2hQynG5H3e4yn4CM6fXf36AcT70kPYKmFbcQCH7SXXZkg4VyVfhu
 EPFrH9rYmLzLRfPkGFi1Qz02uF9/Zt1E3vUw0+DG9adou/Lc4Ndq83SCfiSm6MmDRz8s
 s1D/JRn7aWkc58Nrswu24cJ8DSKi/vsbmPgm6gAHhajuLe1RWjCt6XzHurTyatoUKKtT
 7iVtd1ml8i5VhcahkoMggu5Al7bKaRASIgh9v83JNHCWiqAvE+xNgcz8FYTpsyBAMetU
 3/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8CxQ8M2QM9sBIlwmPDF3sO4KY64cCnbt7okAkRcIdI=;
 b=CZmPPQD0JMae1wiFoMOrbORAEgE7iRpKnG0NTfAW06hQ/GJaoFBz8VOmQetUFr5roH
 O1T18OQUkWOhwS0qIHpi9gNPxM/exrl9EVukOh5tmUkSHYKk2uIrseUUpnbmq+pBUn0F
 MLTnaIUXQ7CclYYqfFTksVzLbifsBcYeeG6L4CsewWp62JeB114mZDw0WiP1drDi2ozQ
 nkmG3/CGirWNtNq7hV3CL6zxGSV4u7FUlj9nH17wKz6SI8gOnroZp1HK831WbeaysLP+
 tzRnL9Mp4wkZ++6KDY/qPiCpswsjMhHcDy58svyStZdgjd2UEhcU9wMFME6e2hIf8S/f
 9UgQ==
X-Gm-Message-State: ACrzQf1e4ziaqB20vvrt3oIy0ifeZCGrg4lyDZXnjAvP97rOQqQQUDEi
 OH1byqI1AtIx9no+OFBZ1hWklw==
X-Google-Smtp-Source: AMsMyM5leRTjPX8cC2BZ8OxRg1qLemGZp+/Aqexr9F666mTxh2xSMl5cDCaV8E5Oxa1vtL+dJHRYXA==
X-Received: by 2002:a17:902:ec92:b0:186:9fc6:868c with SMTP id
 x18-20020a170902ec9200b001869fc6868cmr39074139plg.12.1667633034808; 
 Sat, 05 Nov 2022 00:23:54 -0700 (PDT)
Received: from leoy-huangpu.lan (211-75-219-201.hinet-ip.hinet.net.
 [211.75.219.201]) by smtp.gmail.com with ESMTPSA id
 w27-20020aa79a1b000000b00562ef28aac6sm698138pfj.185.2022.11.05.00.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Nov 2022 00:23:54 -0700 (PDT)
From: Leo Yan <leo.yan@linaro.org>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 John Garry <john.garry@huawei.com>, James Clark <james.clark@arm.com>,
 Mike Leach <mike.leach@linaro.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: [PATCH v1 3/3] perf arm64: Support virtual CPU ID for kvm-stat
Date: Sat,  5 Nov 2022 07:23:11 +0000
Message-Id: <20221105072311.8214-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221105072311.8214-1-leo.yan@linaro.org>
References: <20221105072311.8214-1-leo.yan@linaro.org>
MIME-Version: 1.0
Cc: Leo Yan <leo.yan@linaro.org>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Since the two trace events kvm_entry_v2/kvm_exit_v2 are added, we can
use the field "vcpu_id" in the events to get to know the virtual CPU ID.
To keep backward compatibility, we still need to rely on the trace
events kvm_entry/kvm_exit for old kernels.

This patch adds Arm64's functions setup_kvm_events_tp() and
arm64__setup_kvm_tp(), by detecting the nodes under sysfs folder, it can
dynamically register trace events kvm_entry_v2/kvm_exit_v2 when the
kernel has provided them, otherwise, it rolls back to use events
kvm_entry/kvm_exit for backward compatibility.

Let cpu_isa_init() to invoke arm64__setup_kvm_tp(), this can allow the
command "perf kvm stat report" also to dynamically setup trace events.

Before:

  # perf kvm stat report --vcpu 27

  Analyze events for all VMs, VCPU 27:

               VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time

  Total Samples:0, Total events handled time:0.00us.

After:

  # perf kvm stat report --vcpu 27

  Analyze events for all VMs, VCPU 27:

               VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time

                 SYS64        808    98.54%    91.24%      0.00us    303.76us      3.46us ( +-  13.54% )
                   WFx         10     1.22%     7.79%      0.00us     69.48us     23.91us ( +-  25.91% )
                   IRQ          2     0.24%     0.97%      0.00us     22.64us     14.82us ( +-  52.77% )

  Total Samples:820, Total events handled time:3068.28us.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/kvm-stat.c | 54 ++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/arm64/util/kvm-stat.c b/tools/perf/arch/arm64/util/kvm-stat.c
index 73d18e0ed6f6..1ba54ce3d7d8 100644
--- a/tools/perf/arch/arm64/util/kvm-stat.c
+++ b/tools/perf/arch/arm64/util/kvm-stat.c
@@ -3,6 +3,7 @@
 #include <memory.h>
 #include "../../../util/evsel.h"
 #include "../../../util/kvm-stat.h"
+#include "../../../util/tracepoint.h"
 #include "arm64_exception_types.h"
 #include "debug.h"
 
@@ -10,18 +11,28 @@ define_exit_reasons_table(arm64_exit_reasons, kvm_arm_exception_type);
 define_exit_reasons_table(arm64_trap_exit_reasons, kvm_arm_exception_class);
 
 const char *kvm_trap_exit_reason = "esr_ec";
-const char *vcpu_id_str = "id";
+const char *vcpu_id_str = "vcpu_id";
 const int decode_str_len = 20;
 const char *kvm_exit_reason = "ret";
-const char *kvm_entry_trace = "kvm:kvm_entry";
-const char *kvm_exit_trace = "kvm:kvm_exit";
+const char *kvm_entry_trace;
+const char *kvm_exit_trace;
 
-const char *kvm_events_tp[] = {
+#define NR_TPS	2
+
+static const char *kvm_events_tp_v1[NR_TPS + 1] = {
 	"kvm:kvm_entry",
 	"kvm:kvm_exit",
 	NULL,
 };
 
+static const char *kvm_events_tp_v2[NR_TPS + 1] = {
+	"kvm:kvm_entry_v2",
+	"kvm:kvm_exit_v2",
+	NULL,
+};
+
+const char *kvm_events_tp[NR_TPS + 1];
+
 static void event_get_key(struct evsel *evsel,
 			  struct perf_sample *sample,
 			  struct event_key *key)
@@ -78,8 +89,41 @@ const char * const kvm_skip_events[] = {
 	NULL,
 };
 
-int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
+static int arm64__setup_kvm_tp(struct perf_kvm_stat *kvm)
 {
+	const char **kvm_events, **events_ptr;
+	int i, nr_tp = 0;
+
+	if (is_valid_tracepoint("kvm:kvm_entry_v2")) {
+		kvm_events = kvm_events_tp_v2;
+		kvm_entry_trace = "kvm:kvm_entry_v2";
+		kvm_exit_trace = "kvm:kvm_exit_v2";
+	} else {
+		kvm_events = kvm_events_tp_v1;
+		kvm_entry_trace = "kvm:kvm_entry";
+		kvm_exit_trace = "kvm:kvm_exit";
+	}
+
+	for (events_ptr = kvm_events; *events_ptr; events_ptr++) {
+		if (!is_valid_tracepoint(*events_ptr))
+			return -1;
+		nr_tp++;
+	}
+
+	for (i = 0; i < nr_tp; i++)
+		kvm_events_tp[i] = kvm_events[i];
+	kvm_events_tp[i] = NULL;
+
 	kvm->exit_reasons_isa = "arm64";
 	return 0;
 }
+
+int setup_kvm_events_tp(struct perf_kvm_stat *kvm)
+{
+	return arm64__setup_kvm_tp(kvm);
+}
+
+int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
+{
+	return arm64__setup_kvm_tp(kvm);
+}
-- 
2.34.1

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
