Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2476A3A5BA7
	for <lists+kvmarm@lfdr.de>; Mon, 14 Jun 2021 04:54:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C16924A19E;
	Sun, 13 Jun 2021 22:54:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3jtuzwbIlzTZ; Sun, 13 Jun 2021 22:54:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B2AB04A1FA;
	Sun, 13 Jun 2021 22:54:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 057A149F6C
 for <kvmarm@lists.cs.columbia.edu>; Sun, 13 Jun 2021 22:54:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BUu-QHSh85c4 for <kvmarm@lists.cs.columbia.edu>;
 Sun, 13 Jun 2021 22:54:01 -0400 (EDT)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 67A2740630
 for <kvmarm@lists.cs.columbia.edu>; Sun, 13 Jun 2021 22:54:01 -0400 (EDT)
Received: by mail-qv1-f74.google.com with SMTP id
 10-20020a0562140d4ab0290247bb35d2c3so4239192qvr.22
 for <kvmarm@lists.cs.columbia.edu>; Sun, 13 Jun 2021 19:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=EFssac9rz7i/Qr9EpSWwLvB4XY7qiCj+W7+6Jhxuqag=;
 b=LYERAZ7y42UfbmbPlfdmiRT+5SUAlpPUpcnKAJ06pnxNMruCW5nQs9eoLdhY4QqimU
 Bw60ALBxFeHcd/4Y9jIRzBOR9/jMvrFmonm5knRkEcDKOB3k8Nb4pdzKFF+bTNo8qSkm
 LW4hKTBMV2DNjCzUzntynYfjW6IAKSv/c/Xb2y6CY8rqY5Rw4e+W4wgtv7ZA858F3JCH
 Zl4LhituKwhgS7GcTCyVhu28y+SbW3QLn/N4f5Iatuc8SttyxjK8JXA4Tnh9QopWwUl4
 oZCcRWH9m6pqfBku+n2hHpfC7LViqfP68y/Fz+T5Qfck+/1uBFBrVHOLCvaP8cjdEJAO
 vTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=EFssac9rz7i/Qr9EpSWwLvB4XY7qiCj+W7+6Jhxuqag=;
 b=sa38G1l/qFZaMGVoSiM0B7noUGCOI+DX+5LxHFCLZb9S9S/kPP+nS8OOTfKW3Qc/cE
 f5vD6oGfMd3cqRL3SjkApVamPnRvX/Hnv+cyNxbyf9rADmKapbUvynpBwYz8Q3Lg5sJ6
 dDbH4HjG2OHXW6ysDHca099fnmAaKnN8gg+SGn4dTan2OQgkWDtfwl+TjIN1U3TKO+LB
 pqTSb11S+FsX/zG+0fY/6pfvhXDt959HXGC0/Ym2RIX7V6NrQgthhU2v2OHwQuLI/xkL
 RK9PigReXHYgdTKuouNi1ydjElSshrj/mBE5/v+14d8mdMcLBrE+NE/N4uYwoYqX9cCj
 MPgQ==
X-Gm-Message-State: AOAM530oO2J6yrbI+pD2RL13m+qwNS/tX+mRsiLseGgxZ+enmEex5FmB
 q/90EluP7GJdqdkLoyzNzycXZNL3pnPUUwSmsA==
X-Google-Smtp-Source: ABdhPJx06RmEFcd18ZQJLMbPbZxx739B0LLW3SWUDB8V4bqvcXAZJX+M+bK78AWrb7OsWvWt/mmcsnPMfO++tuNCdA==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a05:6214:20c4:: with SMTP id
 4mr8552573qve.1.1623639240966; Sun, 13 Jun 2021 19:54:00 -0700 (PDT)
Date: Mon, 14 Jun 2021 02:53:50 +0000
In-Reply-To: <20210614025351.365284-1-jingzhangos@google.com>
Message-Id: <20210614025351.365284-4-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210614025351.365284-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH 3/4] KVM: stats: Update documentation supporting stats mode
 and offset
From: Jing Zhang <jingzhangos@google.com>
To: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>, 
 LinuxMIPS <linux-mips@vger.kernel.org>, KVMPPC <kvm-ppc@vger.kernel.org>, 
 LinuxS390 <linux-s390@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fuad Tabba <tabba@google.com>
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

Update documentation to reflect that stats descriptor supports new
flags for read/write mode and an offset field is added in stats
descriptor.

Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 Documentation/virt/kvm/api.rst | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index d1ad30212726..67979700a90e 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -5160,12 +5160,19 @@ below code block::
 	#define KVM_STATS_BASE_POW2		(0x1 << KVM_STATS_BASE_SHIFT)
 	#define KVM_STATS_BASE_MAX		KVM_STATS_BASE_POW2
 
+        #define KVM_STATS_MODE_SHIFT		12
+        #define KVM_STATS_MODE_MASK		(0xF << KVM_STATS_MODE_SHIFT)
+        #define KVM_STATS_MODE_RW		(0x0 << KVM_STATS_MODE_SHIFT)
+        #define KVM_STATS_MODE_READ		(0x1 << KVM_STATS_MODE_SHIFT)
+        #define KVM_STATS_MODE_WRITE		(0x2 << KVM_STATS_MODE_SHIFT)
+        #define KVM_STATS_MODE_MAX		KVM_STATS_MODE_WRITE
+
 	struct kvm_stats_desc {
 		__u32 flags;
 		__s16 exponent;
 		__u16 size;
-		__u32 unused1;
-		__u32 unused2;
+		__u32 offset;
+		__u32 unused;
 		char name[0];
 	};
 
@@ -5212,23 +5219,35 @@ Bits 4-7 of ``flags`` encode the unit:
     value is 200, ``exponent`` is 4, we can get the number of CPU clock cycles
     by ``value * pow(10, exponent) = 200 * pow(10, 4) = 2000000``.
 
-Bits 7-11 of ``flags`` encode the base:
+Bits 8-11 of ``flags`` encode the base:
   * ``KVM_STATS_BASE_POW10``
     The scale is based on power of 10. It is used for measurement of time and
     CPU clock cycles.
   * ``KVM_STATS_BASE_POW2``
     The scale is based on power of 2. It is used for measurement of memory size.
 
+Bits 12-15 of ``flags`` encode the mode:
+  * ``KVM_STATS_MODE_RW``
+    The corresponding statistics supports both read and write (clear).
+  * ``KVM_STATS_MODE_READ``
+    The corresponding statistics supports read only.
+  * ``KVM_STATS_MODE_WRITE``
+    The corresponding statistics supports write only. (Not used for now, added
+    for completeness)
+
 The ``exponent`` field is the scale of corresponding statistics data. For
 example, if the unit is ``KVM_STATS_UNIT_BYTES``, the base is
 ``KVM_STATS_BASE_POW2``, the ``exponent`` is 10, then we know that the real
 unit of the statistics data is KBytes a.k.a pow(2, 10) = 1024 bytes.
 
-The ``size`` field is the number of values of this statistics data. It is in the
-unit of ``unsigned long`` for VM or ``__u64`` for VCPU.
+The ``size`` field is the number of values (u64) of this statistics data. Its
+value is usually 1 for most of simple statistics.
+
+The ``offset`` field is the offset from the start of Data Block to the start of
+the corresponding statistics data.
 
-The ``unused1`` and ``unused2`` fields are reserved for future
-support for other types of statistics data, like log/linear histogram.
+The ``unused`` fields are reserved for future support for other types of
+statistics data, like log/linear histogram.
 
 The ``name`` field points to the name string of the statistics data. The name
 string starts at the end of ``struct kvm_stats_desc``.
-- 
2.32.0.272.g935e593368-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
