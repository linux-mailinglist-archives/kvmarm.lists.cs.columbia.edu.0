Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7A3A5BA2
	for <lists+kvmarm@lfdr.de>; Mon, 14 Jun 2021 04:54:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9926949F92;
	Sun, 13 Jun 2021 22:54:03 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NmYKYWvv+dXX; Sun, 13 Jun 2021 22:54:02 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3F06749F8F;
	Sun, 13 Jun 2021 22:54:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D6287406AD
 for <kvmarm@lists.cs.columbia.edu>; Sun, 13 Jun 2021 22:54:00 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W84h+OiB1e2I for <kvmarm@lists.cs.columbia.edu>;
 Sun, 13 Jun 2021 22:53:57 -0400 (EDT)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id E855340630
 for <kvmarm@lists.cs.columbia.edu>; Sun, 13 Jun 2021 22:53:56 -0400 (EDT)
Received: by mail-pf1-f202.google.com with SMTP id
 i13-20020aa78b4d0000b02902ea019ef670so7461794pfd.0
 for <kvmarm@lists.cs.columbia.edu>; Sun, 13 Jun 2021 19:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=KV1G/R1zSZnSBOo/d7pZSYrqkdhyWDQYDOJ/O2SNH4I=;
 b=kDQEan3QS0HPXWg18LBV2T73SvgN3datzG2XhzaYhgiNgGasOyWf+QJstJsHVasjiW
 IHzlsrAC3QKbwWnobFjsw5ahQCrYI/z+Eo/XT8EEnOSRC18yfBYktADbFbSlLHQ8S6Iw
 FC1ltJ7DqfFoJxfTz4aD7EnlxksQ3aTdcI+rmyvgj4Idgh7lZb28q+rwNp514TO/722o
 f1nR3FVWQj/6t9gKh5sJslnMeKt8oNOfdNRsCkZ7xtm1Vvrk1lrdi+9qJSxpgju6r2Gl
 QRdTdil4be1AJmPnHhHxQ1VFA3c7XtQ0+pzairSTsOJ16N0IKcg1ppAD/RbQQIrPznYI
 RjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=KV1G/R1zSZnSBOo/d7pZSYrqkdhyWDQYDOJ/O2SNH4I=;
 b=SRzbFdPTRx6IA4wXA/c8DfFd9OzDyGWG2WI+IG8ZjBVaH/9Q7Vlyc8AXZ8WB5Emo6p
 7vJnBrqRdWeGHyjlni3v13IEktQE95Iz7mWgusLRNosX8Izd7uQ5SF8BeRPC1/hK0Ha/
 DpKUl12kAl8YXDm2PM9xH+rSIo6b9gLAzoBRxIEzN8wH95Vb9ykHe2gUZt/DpyJ2uSPO
 ZG7TokBJ1iTWxJoQBAD1KiyDDCSX50XZ3aFJw5qGemnwpfbpnDN86Ua0V1SUb0kuJaCh
 yHuxxskFB5kA+XI+zBRnNiLrmYYUqSg+0l7DJO9Q8pFhkzbfYs/37ACw5F3J53iQBxhZ
 LTHg==
X-Gm-Message-State: AOAM530paS7iAExmcgdJR8YxJ0QKtyzhLgqBbJKAut24Whaxih+3ohbs
 DDgQ9fMzHYlFzYCR6R5v+pN0IgJVYHA84dOtXA==
X-Google-Smtp-Source: ABdhPJwRWAstHgo7BVtHEtkFzdNcfslZh+/1MjQ4teaqitIxKeI6I2u0l+pkFtjTmd38Dt65Uu2PIUcSDoZnRDqISg==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a17:902:9008:b029:119:25dd:8646 with
 SMTP id a8-20020a1709029008b029011925dd8646mr10986859plp.41.1623639235855;
 Sun, 13 Jun 2021 19:53:55 -0700 (PDT)
Date: Mon, 14 Jun 2021 02:53:47 +0000
Message-Id: <20210614025351.365284-1-jingzhangos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH 0/4] Remove duplicated stats definitions for debugfs
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

This is a follow-up patchset to binary stats interface patchset as below:
https://lore.kernel.org/kvm/20210611124624.1404010-1-jingzhangos@google.com

This patchset contains a commit to fix some missing stats and add static
check to make sure we have the right number of stats descriptors and add an
'offset' field in stats descriptor to make sure the or order of stats
descriptors is not relevant to the order of stats in vm/vcpu stats
structure. This will totally avoid the possibility of missing stats and
mismatched stats definitions.

The binary stats interface defines stats in another array of descriptors,
while the original stats debugfs interface uses array of kvm_stats_debugfs
item. To remove the duplicated stats definition, this patchset would
utilize only the stats descriptors to provide stats information to debugfs
interface. This patchset adds a 'mode' flag to support the read/write mode
of stats, which can be used to indicate the file permission of debugfs
stats files. It removes the usage of kvm_stats_debugfs_item and all the
debugfs_entries defined in all archs.

The patch also fixes an issue that read only stats could be cleared in
global level, though not permitted in VM level in the original debugfs
code.

---

Jing Zhang (4):
  KVM: stats: Make sure no missing or mismatched binary stats definition
  KVM: stats: Use binary stats descriptors for debugfs interface
  KVM: stats: Update documentation supporting stats mode and offset
  KVM: selftests: Update binary stats test for stats mode

 Documentation/virt/kvm/api.rst                |  33 +-
 arch/arm64/kvm/guest.c                        |  32 +-
 arch/mips/kvm/mips.c                          |  99 ++----
 arch/powerpc/kvm/book3s.c                     | 101 ++----
 arch/powerpc/kvm/booke.c                      |  79 ++---
 arch/s390/kvm/kvm-s390.c                      | 307 ++++++------------
 arch/x86/kvm/x86.c                            | 120 +++----
 include/linux/kvm_host.h                      | 186 ++++++-----
 include/uapi/linux/kvm.h                      |  11 +-
 .../selftests/kvm/kvm_binary_stats_test.c     |  13 +-
 virt/kvm/kvm_main.c                           | 105 ++++--
 11 files changed, 477 insertions(+), 609 deletions(-)


base-commit: 39be2e28180a2e87af5fbb8d83643812e1a3b371
-- 
2.32.0.272.g935e593368-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
