Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BEE50376084
	for <lists+kvmarm@lfdr.de>; Fri,  7 May 2021 08:41:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 71D1D4B449;
	Fri,  7 May 2021 02:41:22 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X7VYbs9726hu; Fri,  7 May 2021 02:41:21 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 49D844B4B6;
	Fri,  7 May 2021 02:41:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id F29944B52D
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 May 2021 02:41:19 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wo1Ukf5BM4ma for <kvmarm@lists.cs.columbia.edu>;
 Fri,  7 May 2021 02:41:19 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 18CE04B28B
 for <kvmarm@lists.cs.columbia.edu>; Fri,  7 May 2021 02:41:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620369679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=88N+p1H52aFWa1qAO1bnhEhJK9rOvXpt4szntFewDdM=;
 b=h2WvniFsElCVPzzWN0dFGWw2p494GgmbQjfY28s6YNh2ow99qLc4hF/n3Ifem6kGCFmvz4
 +4dOU66+s8Ntz2/vAoI8U7LCMQr9q5jvUug7BuUMW9mYrJ1YMM5vkT5q3tzvHPdXg+7jpQ
 CFyQ9BvatRav97ADvd7IDojQSjjCAnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-eda0cuRFPvewr91rTXBsmQ-1; Fri, 07 May 2021 02:41:17 -0400
X-MC-Unique: eda0cuRFPvewr91rTXBsmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D6F5107ACC7;
 Fri,  7 May 2021 06:41:16 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-42.bne.redhat.com [10.64.54.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B48625C276;
 Fri,  7 May 2021 06:41:13 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: kvmarm@lists.cs.columbia.edu
Subject: [PATCH v3 06/15] KVM: arm64: Add paravirtualization header files
Date: Fri,  7 May 2021 16:40:44 +0800
Message-Id: <20210507084053.44407-7-gshan@redhat.com>
In-Reply-To: <20210507084053.44407-1-gshan@redhat.com>
References: <20210507084053.44407-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
 Jonathan.Cameron@huawei.com, pbonzini@redhat.com, will@kernel.org
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

We need put more stuff in the paravirtualization header files when
the asynchronous page fault is supported. The generic header files
can't meet the goal. This duplicate the generic header files to be
our platform specific header files. It's the preparatory work to
support the asynchronous page fault in the subsequent patches:

   include/uapi/asm-generic/kvm_para.h
   include/asm-generic/kvm_para.h

   arch/arm64/include/uapi/asm/kvm_para.h
   arch/arm64/include/asm/kvm_para.h

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_para.h      | 27 ++++++++++++++++++++++++++
 arch/arm64/include/uapi/asm/Kbuild     |  2 --
 arch/arm64/include/uapi/asm/kvm_para.h |  5 +++++
 3 files changed, 32 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_para.h
 create mode 100644 arch/arm64/include/uapi/asm/kvm_para.h

diff --git a/arch/arm64/include/asm/kvm_para.h b/arch/arm64/include/asm/kvm_para.h
new file mode 100644
index 000000000000..0ea481dd1c7a
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_para.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM_KVM_PARA_H
+#define _ASM_ARM_KVM_PARA_H
+
+#include <uapi/asm/kvm_para.h>
+
+static inline bool kvm_check_and_clear_guest_paused(void)
+{
+	return false;
+}
+
+static inline unsigned int kvm_arch_para_features(void)
+{
+	return 0;
+}
+
+static inline unsigned int kvm_arch_para_hints(void)
+{
+	return 0;
+}
+
+static inline bool kvm_para_available(void)
+{
+	return false;
+}
+
+#endif /* _ASM_ARM_KVM_PARA_H */
diff --git a/arch/arm64/include/uapi/asm/Kbuild b/arch/arm64/include/uapi/asm/Kbuild
index 602d137932dc..f66554cd5c45 100644
--- a/arch/arm64/include/uapi/asm/Kbuild
+++ b/arch/arm64/include/uapi/asm/Kbuild
@@ -1,3 +1 @@
 # SPDX-License-Identifier: GPL-2.0
-
-generic-y += kvm_para.h
diff --git a/arch/arm64/include/uapi/asm/kvm_para.h b/arch/arm64/include/uapi/asm/kvm_para.h
new file mode 100644
index 000000000000..cd212282b90c
--- /dev/null
+++ b/arch/arm64/include/uapi/asm/kvm_para.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_ASM_ARM_KVM_PARA_H
+#define _UAPI_ASM_ARM_KVM_PARA_H
+
+#endif /* _UAPI_ASM_ARM_KVM_PARA_H */
-- 
2.23.0

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
