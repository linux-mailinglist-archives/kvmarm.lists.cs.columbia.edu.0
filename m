Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B9C3A39BF74
	for <lists+kvmarm@lfdr.de>; Fri,  4 Jun 2021 20:18:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 32BCC4B11D;
	Fri,  4 Jun 2021 14:18:50 -0400 (EDT)
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
	with ESMTP id jotTbMWY4UNc; Fri,  4 Jun 2021 14:18:50 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id DED974B11C;
	Fri,  4 Jun 2021 14:18:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 92D624B118
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Jun 2021 14:18:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id il9u5ZCCZNiu for <kvmarm@lists.cs.columbia.edu>;
 Fri,  4 Jun 2021 14:18:40 -0400 (EDT)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 6225E405A6
 for <kvmarm@lists.cs.columbia.edu>; Fri,  4 Jun 2021 14:18:40 -0400 (EDT)
Received: by mail-pj1-f74.google.com with SMTP id
 om12-20020a17090b3a8cb029016a4ee7d56fso5672633pjb.7
 for <kvmarm@lists.cs.columbia.edu>; Fri, 04 Jun 2021 11:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=OURJ6TzGdfX+C5aElOfrvLYLXIEwqt+64W7DY078FOs=;
 b=DoohwkvXjAFEjB702S1RR85vweNK+i/nJ9ySyGXZL7k7ooN4RLk2j6KK0JpK4KBp0W
 BUCiT5U1dWIDDUHEwVM7l41dmz4VGvpZC68yGABSBExHHEVCcyStRIbAUKmecH0d3lw0
 WAeJhuBJ4/auMLn3lWtehD0nD9R4kYgREzE0Un51yljJ0Kkkn40uZeXLGZHBrDMZFbku
 B4nAxYWuyr1KCo72Kw/gia2f9dqgfXPC3SsCi2vYLkGHhOf+aK2m8i9J8dOwiGL36dXM
 NUkgGWEj9O1cTJKdJc7xeWZ9KBsejArXk3bHK3N01RJcAJDiym53uZ99msNDGxs+7R97
 YEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=OURJ6TzGdfX+C5aElOfrvLYLXIEwqt+64W7DY078FOs=;
 b=fWoJrZ74evqU+rbeTpmurxghyPTrXgYfDlkLri+3FvgqWFrMdXIsXFV5PBQJ6gicFq
 8h0vYVR1wkSR4P1VK0jlqNkQRO3qockHbskzEKcHrukio/EtyX7F/8Z3MohB9ztJAJ6P
 WzCkdutDd3LIzgdoTwN/VNeIGpcBa47a1dNJv569scIQDOHBmtEuAcmAkhYoe6FiXX9W
 I+a44z413eJrkVZEB0NMioVPVIMbktQz9lysAebM/fiXp2/p3qo7i/MDA2qXk8sVdRzL
 LVT76s6DX4yGDpvDxIC1If3MnFdFtnZ3FKdS27qqq25rOPCzZ8JBbPzgaNCxVchQoMz8
 YkWg==
X-Gm-Message-State: AOAM530I0tSabcj/EaOIse1UtCT25lxRpk0SeR067/mKT2putibNn41m
 Ig28oIg56X/OYUcvQ+jPkZRd2WAgyKM1Exc5EdjqxP5RX3e4+bh3e/V7QLgKKZBPFYIb/1LywRN
 126ZJKuu/bqwl/2SZcSdirNu7MqrcotRZ8lKYQfY336LONHZLepZR8ehY3c6WgUA7hlM506rKFG
 4=
X-Google-Smtp-Source: ABdhPJy9PKCQtJIEuOUg8w1qPNwviZRTxC7lSkcVhvhRw5bRINA/J7AJOwPEGcjkcY9tf+d4n0aJ6rlK3EBbhQ==
X-Received: from ricarkol2.c.googlers.com
 ([fda3:e722:ac3:10:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:a17:90a:c68a:: with SMTP id
 n10mr18432159pjt.32.1622830719294; Fri, 04 Jun 2021 11:18:39 -0700 (PDT)
Date: Fri,  4 Jun 2021 11:18:33 -0700
Message-Id: <20210604181833.1769900-1-ricarkol@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH] KVM: selftests: Rename vm_handle_exception in evmcs test
From: Ricardo Koller <ricarkol@google.com>
To: kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org
Cc: maz@kernel.org, kernel test robot <oliver.sang@intel.com>,
 pbonzini@redhat.com
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

Kernel test robot reports this:

> /usr/bin/ld: tools/testing/selftests/kvm/x86_64/evmcs_test.c:157: undefined reference to `vm_handle_exception'
> /usr/bin/ld: tools/testing/selftests/kvm/x86_64/evmcs_test.c:158: undefined reference to `vm_handle_exception'
> collect2: error: ld returned 1 exit status

Fix it by renaming vm_handle_exception to vm_install_vector_handler in
evmcs_test.c.

Fixes: a2bad6a990a4 ("KVM: selftests: Rename vm_handle_exception")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 tools/testing/selftests/kvm/x86_64/evmcs_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
index 63096cea26c6..278711723f4b 100644
--- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
@@ -154,8 +154,8 @@ int main(int argc, char *argv[])
 
 	vm_init_descriptor_tables(vm);
 	vcpu_init_descriptor_tables(vm, VCPU_ID);
-	vm_handle_exception(vm, UD_VECTOR, guest_ud_handler);
-	vm_handle_exception(vm, NMI_VECTOR, guest_nmi_handler);
+	vm_install_vector_handler(vm, UD_VECTOR, guest_ud_handler);
+	vm_install_vector_handler(vm, NMI_VECTOR, guest_nmi_handler);
 
 	pr_info("Running L1 which uses EVMCS to run L2\n");
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
