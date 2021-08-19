Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2B13F23C6
	for <lists+kvmarm@lfdr.de>; Fri, 20 Aug 2021 01:42:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6E13E4B11A;
	Thu, 19 Aug 2021 19:42:11 -0400 (EDT)
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
	with ESMTP id 2jgJ4NJqAZfc; Thu, 19 Aug 2021 19:42:11 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 685D34B119;
	Thu, 19 Aug 2021 19:42:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C1E8E4B0C3
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Aug 2021 19:42:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KDrm+kA1qzHL for <kvmarm@lists.cs.columbia.edu>;
 Thu, 19 Aug 2021 19:42:05 -0400 (EDT)
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com
 [209.85.166.73])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id CD5674B08D
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Aug 2021 19:42:05 -0400 (EDT)
Received: by mail-io1-f73.google.com with SMTP id
 k21-20020a5e93150000b02905b30d664397so4325070iom.0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Aug 2021 16:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=/0OMjN/h8z3QOxG0xTT9R/7SiBAh42bxZ0UDmtmp5Ok=;
 b=McLLjVqZw9/DLQ6myoLXBd1HCxzyu2Buz0DI48N8xlHLKObry0AIzIbeJnj9cxGJPB
 AzPUI/A7of4JO1ICGVviwA7+CgvoMp1ao/mnyOwsgEpYH9MDF3HelFRT4S6U/EHz9lF0
 2QY6bNyu05fdTHVRxkfOrzDeyYtPyJxehrm2Onfl7Hu29GHiHgr2iN6aZcuXSOI2TP2f
 vyn6Mx0C5t0KDCsPzcy2wp2mEbAeCIDz2qyFnvHACrmpzL9oZ9c8frh7z+JheWJDO0Hr
 gZ9SG0fuN3zCiufw3em2BxEFg7Ljulf42+mQmN5q08GbPf4WGeVhE3INvF//5hmtX1sP
 YKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=/0OMjN/h8z3QOxG0xTT9R/7SiBAh42bxZ0UDmtmp5Ok=;
 b=um10CHJogT9OcYyAPsVVMRnwKWIeQOeNhK03GJSksudT49OrD9Cn55dHUlGxuk8gx7
 mMuvdRK1A8hnPWLC5sa0eS5BR2Ph4n4QriBhxHQY+smi/k/1OsAHr9VAxn8Nv6414wiM
 Aa5F7di3d3Wj28BIZJ9mwoOFoCj+cK9zMqAZCai49KCwsa9CdOPx8PHd7SOGKw9n3aMH
 lPH6/xXf2ak+e61KN1I3Bw/4Vp3joVELdRgb5GWZX5Oz/G6dWioMDsV5FFP8s65l6DQV
 hWKoD9kmr0kQph1ukhh9/wby2TYArCh81IdTfsw9bUXkJUTxwvFovj2C4/IKP/XsuYYU
 xJnA==
X-Gm-Message-State: AOAM530l65TkW1uxiJ+qnL4gVj74gpRSlR2nFpLJZHuI0HziW5sLOXwX
 6YoY9JOvElnd4UPTUK30am7wHEGHvec=
X-Google-Smtp-Source: ABdhPJwEvHvNfN4h3UNOhf35nFKUXzTJy88XHWag7W5Cmin+j2sU1JiG7Xa0XPza8UDTgOfGMq6AKZ65uC4=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a02:5107:: with SMTP id
 s7mr15206839jaa.65.1629416524925; 
 Thu, 19 Aug 2021 16:42:04 -0700 (PDT)
Date: Thu, 19 Aug 2021 23:41:42 +0000
In-Reply-To: <20210819223640.3564975-1-oupton@google.com>
Message-Id: <20210819234142.3581631-1-oupton@google.com>
Mime-Version: 1.0
References: <20210819223640.3564975-1-oupton@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH] Documentation: kvm: Document KVM_SYSTEM_EVENT_SUSPEND exit
 type
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
 Raghavendra Rao Anata <rananta@google.com>
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

KVM now has the capability to exit to userspace for VM suspend events.
Document the intended UAPI behavior, such that a VMM can simply ignore
the guest intentions and resume.

Signed-off-by: Oliver Upton <oupton@google.com>
---
 Documentation/virt/kvm/api.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index dae68e68ca23..d4dfc6f84dfc 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -5632,6 +5632,7 @@ should put the acknowledged interrupt vector into the 'epr' field.
   #define KVM_SYSTEM_EVENT_SHUTDOWN       1
   #define KVM_SYSTEM_EVENT_RESET          2
   #define KVM_SYSTEM_EVENT_CRASH          3
+  #define KVM_SYSTEM_EVENT_SUSPEND        4
 			__u32 type;
 			__u64 flags;
 		} system_event;
@@ -5656,6 +5657,10 @@ Valid values for 'type' are:
    has requested a crash condition maintenance. Userspace can choose
    to ignore the request, or to gather VM memory core dump and/or
    reset/shutdown of the VM.
+ - KVM_SYSTEM_EVENT_SUSPEND -- the guest has requested that the VM
+   suspends. Userspace is not obliged to honor this, and may call KVM_RUN
+   again. Doing so will cause the guest to resume at its requested entry
+   point.
 
 ::
 
-- 
2.33.0.rc2.250.ged5fa647cd-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
