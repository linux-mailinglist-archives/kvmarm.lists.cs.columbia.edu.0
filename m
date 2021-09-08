Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id DBD2C404064
	for <lists+kvmarm@lfdr.de>; Wed,  8 Sep 2021 23:03:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 84E914B0C2;
	Wed,  8 Sep 2021 17:03:28 -0400 (EDT)
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
	with ESMTP id QdPDGMCv8avM; Wed,  8 Sep 2021 17:03:27 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 95E904B0E7;
	Wed,  8 Sep 2021 17:03:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 6419D4B0F4
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Sep 2021 17:03:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gMcjsB2-tjtN for <kvmarm@lists.cs.columbia.edu>;
 Wed,  8 Sep 2021 17:03:25 -0400 (EDT)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4155D4B091
 for <kvmarm@lists.cs.columbia.edu>; Wed,  8 Sep 2021 17:03:25 -0400 (EDT)
Received: by mail-pf1-f201.google.com with SMTP id
 r1-20020a62e401000000b003f27c6ae031so2072527pfh.20
 for <kvmarm@lists.cs.columbia.edu>; Wed, 08 Sep 2021 14:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=2d4nfleHWQk6Q9Qf0G0fpUlHYSowf2WbKKEPepaq7rY=;
 b=KO8+nZdJPGaZn8QnoYwVIdO6MCYkmTZJPROR2cBbazw7mJE6hHqqcxlqlX8x9nMenR
 1JnAjdtTMrvnwytbbDZGN96cia+5bwznuBBTpvRNfUvFfxXkklisBDog+L6QKk26Mdbj
 Ngyd6TF4iRVnj5SxMEdxyZb51mCZAUEI+f6hFIH4WHkd2usMHpnZLm/Zv/tBDdPj4VPq
 cRdMMaYlGTf122Cbg0BVD8wlsk871xqLrF1acNbFtDPlvpqku80pwdArsR9I0KvQOPn+
 w16PtXopOwPEvTYencl/xsWmv750SZsVi9OYo4tvaujFP8xWEPScXr5GHU32Jz6xKfjN
 NfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=2d4nfleHWQk6Q9Qf0G0fpUlHYSowf2WbKKEPepaq7rY=;
 b=W3wb7QIrcIqF8XQUlNqVcV5P88awtzRxGvCtGob4sGboSBw5INGUFSfHfP8VnMmeBw
 C+UiYbqNEUYqRO9zt4HDk5kMOF9eJ3chwKupYpK9DEm/ZY2RAEHGunaewZDk5QquaUA3
 QfpXl/epmv+Ioq9IQ0G+PnFoUaFLEEovGJBl1bd2UQlvprBqBvyAzo/52ezW7biSiUfE
 2S7rm5BYtBMrZz22wpFKf/k8s71ZbBCt4HtopAdm/uMuW0y9uEqCW+YW7U5wo4x4ek/F
 CjMuv+PXFiVRleOMzGSZBzI+JpDxgXLHk2RGpHlnbWh9eyI+YuVUosqqsxRXUR3aeJxy
 5TUg==
X-Gm-Message-State: AOAM533kxHgE7RpcDURVlrJ0P78WuujG9S55Vr676+Qt6UhFZnzIVaps
 pSo1+nUkKV/UTRYN+f2eyK+gw3nq34ST9Q==
X-Google-Smtp-Source: ABdhPJwIVSsg5yuM194jxyxXA4Dmfrn64eyhBy1C61zVrAz4sOc5g0bQEJ0nBw/uh8TR18zcER/UzQnsrIK3MA==
X-Received: from ricarkol2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:a17:90a:dc15:: with SMTP id
 i21mr168843pjv.64.1631135004439; Wed, 08 Sep 2021 14:03:24 -0700 (PDT)
Date: Wed,  8 Sep 2021 14:03:19 -0700
In-Reply-To: <20210908210320.1182303-1-ricarkol@google.com>
Message-Id: <20210908210320.1182303-2-ricarkol@google.com>
Mime-Version: 1.0
References: <20210908210320.1182303-1-ricarkol@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH 1/2] KVM: arm64: vgic: check redist region is not above the VM
 IPA size
From: Ricardo Koller <ricarkol@google.com>
To: kvm@vger.kernel.org, maz@kernel.org, kvmarm@lists.cs.columbia.edu, 
 drjones@redhat.com, eric.auger@redhat.com, alexandru.elisei@arm.com
Cc: pshier@google.com, Paolo Bonzini <pbonzini@redhat.com>, shuah@kernel.org
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

Extend vgic_v3_check_base() to verify that the redistributor regions
don't go above the VM-specified IPA size (phys_size). This can happen
when using the legacy KVM_VGIC_V3_ADDR_TYPE_REDIST attribute with:

  base + size > phys_size AND base < phys_size

vgic_v3_check_base() is used to check the redist regions bases when
setting them (with the vcpus added so far) and when attempting the first
vcpu-run.

Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/arm64/kvm/vgic/vgic-v3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 66004f61cd83..5afd9f6f68f6 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -512,6 +512,10 @@ bool vgic_v3_check_base(struct kvm *kvm)
 		if (rdreg->base + vgic_v3_rd_region_size(kvm, rdreg) <
 			rdreg->base)
 			return false;
+
+		if (rdreg->base + vgic_v3_rd_region_size(kvm, rdreg) >
+			kvm_phys_size(kvm))
+			return false;
 	}
 
 	if (IS_VGIC_ADDR_UNDEF(d->vgic_dist_base))
-- 
2.33.0.153.gba50c8fa24-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
