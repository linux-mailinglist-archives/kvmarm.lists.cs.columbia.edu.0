Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7D5429C95
	for <lists+kvmarm@lfdr.de>; Tue, 12 Oct 2021 06:36:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id CEC9C4B0DD;
	Tue, 12 Oct 2021 00:36:47 -0400 (EDT)
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
	with ESMTP id 2k81IpJdOivg; Tue, 12 Oct 2021 00:36:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 741CE4B10E;
	Tue, 12 Oct 2021 00:36:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4F2AB4B0CB
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Oct 2021 00:36:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mu97AgKPrFSH for <kvmarm@lists.cs.columbia.edu>;
 Tue, 12 Oct 2021 00:36:43 -0400 (EDT)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id EC3DD4ACC9
 for <kvmarm@lists.cs.columbia.edu>; Tue, 12 Oct 2021 00:36:42 -0400 (EDT)
Received: by mail-qv1-f74.google.com with SMTP id
 gw8-20020a0562140f0800b0038366347de1so5554833qvb.16
 for <kvmarm@lists.cs.columbia.edu>; Mon, 11 Oct 2021 21:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=W3IwbsI0k+1QwX+TAHKvccKyulobDPeUG2CVSppLk2E=;
 b=TfiizDughOv6XpmrE/B/ta2oJtWh1KOl7oRghEckpq0jtU04giMWrFXne9m7+dzkv6
 +vDn6LO6SZHnG6Q2pROAG2PQBSDXREyd22lMQG+lxRGsSADq1E+VnO1Z7WqkDHfrJlNO
 EVH0Yg/uVDi2saPJf04+wIlOaX6lLvVlRsChENQhZNP7PXPXCNlE+6otUV3bnagcPn4z
 Yx6SBV7yyfslru2sqW6hIZHTINV96lf4W7ad0FwkZXwvoj8/k7dfbQXIV11HMFzC35M9
 3BWa+zuJL4S/hTBSHGuyaF8QFy7mPEwc4ITx69ZWKUdntSI1EIJBbI4KYAjAoqtTxm/c
 HEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=W3IwbsI0k+1QwX+TAHKvccKyulobDPeUG2CVSppLk2E=;
 b=jiswkBC05hGJRTdps3d/GMA/tDAGcOgqtz5STLWi8OzlmnciSbHmtCRLHj91R46nGq
 jVpcli0QhRTPZ+mCH3vhsRgnm7AVtoWI7A/Ddb1IHlC6jlQj6Fp/K1CNkp34ssB6ypcS
 VsMyxxzCOnl/yp+FOQsP3uS7Oq7Xu8kc77dIfOut0dw62bjDoz7rEphapE+6pexllXC4
 T/ngVrxoOvvA+1Yx5h0R/yE80g1AO4YSOyliQtyAoH1ORlbund8eomVoGyNZN0hXgdLL
 wLegzun/l++yuGnGYExa7095Dh4KKCr5IdUnFT4cVAfrcgtAlDNoljTst0ZU2tPt4DXP
 gP4g==
X-Gm-Message-State: AOAM530hhNFh1wBcJ60eHlRyIXz0YVD7Opv3tuuwSqwPKuwaFh8UKxog
 T3pERK1C2wdM2DqNYVPvykDZwUpFEYg=
X-Google-Smtp-Source: ABdhPJzqRlxJ4C5xz9JQufFpuXIYDJjLzFExk6TNCvlIXorPpPAh6QasGboxtVmBj45EPB8PnMerC+dbHno=
X-Received: from reiji-vws.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:15a3])
 (user=reijiw job=sendgmr) by 2002:a05:622a:1a0b:: with SMTP id
 f11mr12653018qtb.133.1634013402619; Mon, 11 Oct 2021 21:36:42 -0700 (PDT)
Date: Mon, 11 Oct 2021 21:35:25 -0700
In-Reply-To: <20211012043535.500493-1-reijiw@google.com>
Message-Id: <20211012043535.500493-16-reijiw@google.com>
Mime-Version: 1.0
References: <20211012043535.500493-1-reijiw@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [RFC PATCH 15/25] KVM: arm64: Introduce KVM_CAP_ARM_ID_REG_WRITABLE
 capability
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

Introduce a new capability KVM_CAP_ARM_ID_REG_WRITABLE to indicate
that ID registers are writable by userspace.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
---
 Documentation/virt/kvm/api.rst | 8 ++++++++
 arch/arm64/kvm/arm.c           | 1 +
 include/uapi/linux/kvm.h       | 1 +
 3 files changed, 10 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index a6729c8cf063..f7dfb5127310 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7265,3 +7265,11 @@ The argument to KVM_ENABLE_CAP is also a bitmask, and must be a subset
 of the result of KVM_CHECK_EXTENSION.  KVM will forward to userspace
 the hypercalls whose corresponding bit is in the argument, and return
 ENOSYS for the others.
+
+8.35 KVM_CAP_ARM_ID_REG_WRITABLE
+--------------------------------
+
+:Architectures: arm64
+
+This capability indicates that userspace can modify the ID registers
+via KVM_SET_ONE_REG ioctl.
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 820f35051d77..29c13a32dd21 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -197,6 +197,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_SET_GUEST_DEBUG:
 	case KVM_CAP_VCPU_ATTRIBUTES:
 	case KVM_CAP_PTP_KVM:
+	case KVM_CAP_ARM_ID_REG_WRITABLE:
 		r = 1;
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index a067410ebea5..3345a57f05a6 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1112,6 +1112,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_BINARY_STATS_FD 203
 #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
 #define KVM_CAP_ARM_MTE 205
+#define KVM_CAP_ARM_ID_REG_WRITABLE 206
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.33.0.882.g93a45727a2-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
