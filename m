Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DC17F3A712A
	for <lists+kvmarm@lfdr.de>; Mon, 14 Jun 2021 23:22:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7CEB94B0A1;
	Mon, 14 Jun 2021 17:22:02 -0400 (EDT)
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
	with ESMTP id Mqo2jHE+nrav; Mon, 14 Jun 2021 17:22:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 393A44A5A0;
	Mon, 14 Jun 2021 17:22:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7443A4A1FA
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Jun 2021 17:22:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NyII-5UKa6Fq for <kvmarm@lists.cs.columbia.edu>;
 Mon, 14 Jun 2021 17:21:59 -0400 (EDT)
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com
 [209.85.215.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 179E340C88
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Jun 2021 17:21:59 -0400 (EDT)
Received: by mail-pg1-f202.google.com with SMTP id
 u7-20020a6345470000b02902211e79e4c1so7469126pgk.18
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Jun 2021 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=SlycgcgP2oQfG/m1tsRJUCUu6HgyYclxJAGE9lbfI7I=;
 b=J5OsUMD3R5is1cvWM/Tf1GSvgvYrw1ZTFA6WV9mLsYov03y0xK/HdMK6yCJsYckKRo
 TtGE8n4Fxq4EYtG5ozUsMbV4AkLNWy6LWw1l/UrYBiYJu0fC4BCnkbAiprvyp67AI3ez
 ++RPtlvVdFNIPeK0a8u7bdfuzu81cD4Qr5bFuVp+KHu3u+cD9+BzjSE+HCFtNuDlrUSs
 4IlHyplTtL9gmtWN9jVHfwL72LuuWxHzrtkVsRISlOX67uSROjJCiF8xz508A4WqzgR2
 QZih02YKtsk/ChyGZd7Eon8GpWthGvOj55UNC2eUCNQplIFeeOGWlfJrOndDtyOb0zWF
 m4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=SlycgcgP2oQfG/m1tsRJUCUu6HgyYclxJAGE9lbfI7I=;
 b=bVnS9jywF4ojP3eHaDnh8TBl96OCUel9XoDYoMXNzR7L/DgvWSz9s6vGKa+qv17/4s
 8BGCxvHH1d2OkRbugt0tBwcS63clbCZMJJDCTkyX21PKWn1LYvaTwFeRRIPw/3jvKDh9
 Z4+5d135ac6X9JRw2PrStEfE6EEDWRnvvdXJVHM0mLNNqscFQ7y9kL/rznT3OOzCSluu
 0ciIfJ4MhzHWNZjrCyGbg3qfGZ8P61EKzcZvOaMR76lVSCYEvaczkowP3gF2jOPmIrEr
 hCcRNjCDP0SCqHFeccZC9/6NMWccbCzZ7wh7bxQk0uxpuBWK+MjQNKNnLlwGWPTBecXU
 Jryg==
X-Gm-Message-State: AOAM530ZpeOe1YWHH94NBYGl88bjkedwzFL1OO+0ogZC5Wofhz22YNen
 z+GyRD/FoOMvuJ4fEBtaUMYal9cGaJgCLFk16A==
X-Google-Smtp-Source: ABdhPJz2FI55sVryTZAxtgeRMOOpHWs/+X17g6DjdqznoExrtjOxluBZp09o2sArM1nsheTY/TttMFSWE8kjHPwfdA==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a17:902:7d8c:b029:105:2b81:3915 with
 SMTP id a12-20020a1709027d8cb02901052b813915mr985196plm.71.1623705717928;
 Mon, 14 Jun 2021 14:21:57 -0700 (PDT)
Date: Mon, 14 Jun 2021 21:21:50 +0000
Message-Id: <20210614212155.1670777-1-jingzhangos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v9 0/5] KVM statistics data fd-based binary interface
From: Jing Zhang <jingzhangos@google.com>
To: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>, 
 LinuxMIPS <linux-mips@vger.kernel.org>, KVMPPC <kvm-ppc@vger.kernel.org>, 
 LinuxS390 <linux-s390@vger.kernel.org>, 
 Linuxkselftest <linux-kselftest@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Paul Mackerras <paulus@ozlabs.org>, 
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, 
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Sean Christopherson <seanjc@google.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>, 
 Peter Shier <pshier@google.com>, Oliver Upton <oupton@google.com>, 
 David Rientjes <rientjes@google.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>, 
 David Matlack <dmatlack@google.com>, Ricardo Koller <ricarkol@google.com>, 
 Krish Sadhukhan <krish.sadhukhan@oracle.com>, Fuad Tabba <tabba@google.com>
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

This patchset provides a file descriptor for every VM and VCPU to read
KVM statistics data in binary format.
It is meant to provide a lightweight, flexible, scalable and efficient
lock-free solution for user space telemetry applications to pull the
statistics data periodically for large scale systems. The pulling
frequency could be as high as a few times per second.
In this patchset, every statistics data are treated to have some
attributes as below:
  * architecture dependent or generic
  * VM statistics data or VCPU statistics data
  * type: cumulative, instantaneous, peak
  * unit: none for simple counter, nanosecond, microsecond,
    millisecond, second, Byte, KiByte, MiByte, GiByte. Clock Cycles
Since no lock/synchronization is used, the consistency between all
the statistics data is not guaranteed. That means not all statistics
data are read out at the exact same time, since the statistics date
are still being updated by KVM subsystems while they are read out.

---

* v8 -> v9
  - Rebase to commit 8331a2bc0898
    (KVM: X86: Introduce KVM_HC_MAP_GPA_RANGE hypercall)
  - Reduce code duplication between binary and debugfs interface
  - Add field "offset" in stats descriptor to let us define stats
    descriptors in any order (not necessary in the order of stats
    defined in vm/vcpu stats structures)
  - Add static check to make sure the number of stats descriptors
    is the same as the number of stats defined in vm/vcpu stats
    structures
  - Fix missing/mismatched stats descriptor definition caused by
    rebase

* v7 -> v8
  - Rebase to kvm/queue, commit c1dc20e254b4 ("KVM: switch per-VM
  stats to u64")
  - Revise code to reflect the per-VM stats type from ulong to u64
  - Addressed some other nits

* v6 -> v7
  - Improve file descriptor allocation function by Krish suggestion
  - Use "generic stats" instead of "common stats" as Krish suggested
  - Addressed some other nits from Krish and David Matlack

* v5 -> v6
  - Use designated initializers for STATS_DESC
  - Change KVM_STATS_SCALE... to KVM_STATS_BASE...
  - Use a common function for kvm_[vm|vcpu]_stats_read
  - Fix some documentation errors/missings
  - Use TEST_ASSERT in selftest
  - Use a common function for [vm|vcpu]_stats_test in selftest

* v4 -> v5
  - Rebase to kvm/queue, commit a4345a7cecfb ("Merge tag
    'kvmarm-fixes-5.13-1'")
  - Change maximum stats name length to 48
  - Replace VM_STATS_COMMON/VCPU_STATS_COMMON macros with stats
    descriptor definition macros.
  - Fixed some errors/warnings reported by checkpatch.pl

* v3 -> v4
  - Rebase to kvm/queue, commit 9f242010c3b4 ("KVM: avoid "deadlock"
    between install_new_memslots and MMU notifier")
  - Use C-stype comments in the whole patch
  - Fix wrong count for x86 VCPU stats descriptors
  - Fix KVM stats data size counting and validity check in selftest

* v2 -> v3
  - Rebase to kvm/queue, commit edf408f5257b ("KVM: avoid "deadlock"
    between install_new_memslots and MMU notifier")
  - Resolve some nitpicks about format

* v1 -> v2
  - Use ARRAY_SIZE to count the number of stats descriptors
  - Fix missing `size` field initialization in macro STATS_DESC

[1] https://lore.kernel.org/kvm/20210402224359.2297157-1-jingzhangos@google.com
[2] https://lore.kernel.org/kvm/20210415151741.1607806-1-jingzhangos@google.com
[3] https://lore.kernel.org/kvm/20210423181727.596466-1-jingzhangos@google.com
[4] https://lore.kernel.org/kvm/20210429203740.1935629-1-jingzhangos@google.com
[5] https://lore.kernel.org/kvm/20210517145314.157626-1-jingzhangos@google.com
[6] https://lore.kernel.org/kvm/20210524151828.4113777-1-jingzhangos@google.com
[7] https://lore.kernel.org/kvm/20210603211426.790093-1-jingzhangos@google.com
[8] https://lore.kernel.org/kvm/20210611124624.1404010-1-jingzhangos@google.com

---

Jing Zhang (5):
  KVM: stats: Separate generic stats from architecture specific ones
  KVM: stats: Add fd-based API to read binary stats data
  KVM: stats: Add documentation for statistics data binary interface
  KVM: selftests: Add selftest for KVM statistics data binary interface
  KVM: stats: Remove code duplication for binary and debugfs stats

 Documentation/virt/kvm/api.rst                | 177 +++++++++++-
 arch/arm64/include/asm/kvm_host.h             |   9 +-
 arch/arm64/kvm/guest.c                        |  50 +++-
 arch/mips/include/asm/kvm_host.h              |   9 +-
 arch/mips/kvm/mips.c                          |  92 +++---
 arch/powerpc/include/asm/kvm_host.h           |   9 +-
 arch/powerpc/kvm/book3s.c                     |  93 ++++---
 arch/powerpc/kvm/book3s_hv.c                  |  12 +-
 arch/powerpc/kvm/book3s_pr.c                  |   2 +-
 arch/powerpc/kvm/book3s_pr_papr.c             |   2 +-
 arch/powerpc/kvm/booke.c                      |  78 ++++--
 arch/s390/include/asm/kvm_host.h              |   9 +-
 arch/s390/kvm/kvm-s390.c                      | 234 +++++++++-------
 arch/x86/include/asm/kvm_host.h               |   9 +-
 arch/x86/kvm/x86.c                            | 111 +++++---
 include/linux/kvm_host.h                      | 178 +++++++++++-
 include/linux/kvm_types.h                     |  12 +
 include/uapi/linux/kvm.h                      |  48 ++++
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |   3 +
 .../selftests/kvm/kvm_binary_stats_test.c     | 225 +++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +
 virt/kvm/kvm_main.c                           | 261 +++++++++++++++---
 24 files changed, 1293 insertions(+), 346 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/kvm_binary_stats_test.c


base-commit: 8331a2bc089881d7fd2fc9a6658f39780817e4e0
-- 
2.32.0.272.g935e593368-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
