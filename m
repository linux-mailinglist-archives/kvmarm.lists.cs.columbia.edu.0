Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 90169429C93
	for <lists+kvmarm@lfdr.de>; Tue, 12 Oct 2021 06:36:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4039A4B0FB;
	Tue, 12 Oct 2021 00:36:45 -0400 (EDT)
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
	with ESMTP id OrAyM4woZqtL; Tue, 12 Oct 2021 00:36:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 4235C4B11B;
	Tue, 12 Oct 2021 00:36:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C50474B099
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Oct 2021 00:36:41 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V3HAPHNIykm4 for <kvmarm@lists.cs.columbia.edu>;
 Tue, 12 Oct 2021 00:36:40 -0400 (EDT)
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com
 [209.85.215.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B51454B10D
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Oct 2021 00:36:39 -0400 (EDT)
Received: by mail-pg1-f202.google.com with SMTP id
 q23-20020a6562570000b029023cbfb4fd73so8011571pgv.14
 for <kvmarm@lists.cs.columbia.edu>; Mon, 11 Oct 2021 21:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=1CPPpn8KI1TMZ7GOgYY97mtQvxGoDF5nzyvksmCa+Fo=;
 b=Aa/p3+3YZnA0JDS8zWOXEXRZ2ZxkPrOLUOlaX3VyAf7LudzDEdPB3CLJ1YVKMe7L9G
 Wb8CyupAqRRvvfXLbGdNalJb9N1cIo9LYCHTskPgOkE6h6lfDwn+y9/uxIl8ygZCkOUD
 CNPuFzpb9ztvN1IozmoW1sGZpIedv4EjEUpJDMCY/hS2AgqJE8x+CTgsRrNjDDZqbME8
 l90jqzqQhgg5JVyOWjLQ+mT6BS5zOh9zM/vLwhRCm0ZtrfpE4PF9CW58QdPjF02Dt0jz
 6HZjuCYbrZSCLV4LiEZqfciTJsA8zVhac0Rle06fMkXQhjS2DhUlWMc4fK9x5TOiAgvs
 bU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=1CPPpn8KI1TMZ7GOgYY97mtQvxGoDF5nzyvksmCa+Fo=;
 b=wp4keqA2NCLrEPBwNjQnqp3DXNE05fjfbuuPMFJGOia01N6ROveUdutZwSdcfihsl1
 Hbz6WslATYcTTVKC3k00hvGdcE9erF4iUa9DUAGsp+D8xld3vWRZQb6kNiAXpVV0Ya6y
 /mQnmHuEVnvHioRKVYBplfT52D9TJ67Pq7wSU8ckJTlv3z/eyUfP6a6Cq9zUQ/rAO5Rh
 DtyXnahaWQNSyHJ0S/7zg32Z98gXyPxT7oANKne1ZRInY9JuPg5cpODpJ7MHq3XC3IOi
 QYtVn9dGq4q4LWq7exapr0acfdyFBcCdZTxmgHzhjYIMTCQhdVDWa4OSGn9TT+0cE9CB
 Qz0w==
X-Gm-Message-State: AOAM530TbolM2NLBb5ipYzvizBip0DBqZyUglEXjcAhP71KvvrjpHAdX
 irJFgGXW+gtIaWDL6hC8ml/h7igS33U=
X-Google-Smtp-Source: ABdhPJw94QBclZTr8KRoQua2KsoSUSz/7GaRlZ1blagFA4MtNarr7PzT8SqQ7pJ7+LRN050secmOa62Uv/c=
X-Received: from reiji-vws.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:15a3])
 (user=reijiw job=sendgmr) by 2002:a05:6a00:984:b0:44c:e996:fc2d with SMTP id
 u4-20020a056a00098400b0044ce996fc2dmr20321105pfg.31.1634013398952; Mon, 11
 Oct 2021 21:36:38 -0700 (PDT)
Date: Mon, 11 Oct 2021 21:35:23 -0700
In-Reply-To: <20211012043535.500493-1-reijiw@google.com>
Message-Id: <20211012043535.500493-14-reijiw@google.com>
Mime-Version: 1.0
References: <20211012043535.500493-1-reijiw@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [RFC PATCH 13/25] KVM: arm64: Make ID registers without id_reg_info
 writable
From: Reiji Watanabe <reijiw@google.com>
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Shier <pshier@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-arm-kernel@lists.infradead.org
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

Make ID registers that don't have id_reg_info writable.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/kvm/sys_regs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 71cfd62f9c85..2c092136cdff 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1625,12 +1625,8 @@ static int __set_id_reg(struct kvm_vcpu *vcpu,
 	if (err)
 		return err;
 
-	/* Don't allow to change the reg unless the reg has id_reg_info */
-	if (val != read_id_reg(vcpu, rd, raz) && !GET_ID_REG_INFO(encoding))
-		return -EINVAL;
-
 	/* Don't allow to change the reg after the first KVM_RUN. */
-	if (vcpu->arch.has_run_once)
+	if ((val != read_id_reg(vcpu, rd, raz)) && vcpu->arch.has_run_once)
 		return -EINVAL;
 
 	if (raz)
-- 
2.33.0.882.g93a45727a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
