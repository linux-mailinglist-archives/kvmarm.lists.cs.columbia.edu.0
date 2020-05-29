Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D32F91E7BBC
	for <lists+kvmarm@lfdr.de>; Fri, 29 May 2020 13:28:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 5861D4B25C;
	Fri, 29 May 2020 07:28:53 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@linaro.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kXQP4J+EbEe1; Fri, 29 May 2020 07:28:53 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1CD584B255;
	Fri, 29 May 2020 07:28:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3C4E74B182
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 May 2020 07:28:51 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O26wjxN0wFNp for <kvmarm@lists.cs.columbia.edu>;
 Fri, 29 May 2020 07:28:50 -0400 (EDT)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 150344B17F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 May 2020 07:28:50 -0400 (EDT)
Received: by mail-wm1-f67.google.com with SMTP id h4so2861344wmb.4
 for <kvmarm@lists.cs.columbia.edu>; Fri, 29 May 2020 04:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=wKZ/XG+QT1qtovyr0q0rEdp/rI8bv2otMbHbRlqHsoY=;
 b=mkVlHAR/W7MuyANeOmDncItez0ATFdX67xIGtWfurGN7edQgrFjFgR09qFnuYJh23E
 uo2Lyg7h+Ba0/MF9oJa+0DE2OiK1yMeZCvxCWTsVr+Ydsc2wUWrTZiGrTgmNwhW6qPcS
 ZonLbKoDeFXRVYmIH84Wn6/qKuq0TKCBCLCjkkKkNBqHGe0qYAcNCy+yshzLNjrnSR3t
 zff+tj5yCvnPDFsK2oib3Lz9mGgx2OoTrav0WCXH7sXQlSLTP91UAcafNyo7lNBclrIH
 ISLqgCiwhIPSwwBj9qxjvUmk/9O4ZIR2q2S9Z/pT9vE+xbpxnqt5MFfytY22JWAr216l
 MAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wKZ/XG+QT1qtovyr0q0rEdp/rI8bv2otMbHbRlqHsoY=;
 b=fY7Lx1mJR4FTItzjX+O7riwoVlekt6/C2buf1Poyf7xiUgrnS2p9c7qo7DdVRtY0yX
 +ZqaNlQ5of4wtV0TPVUk0ovmmIUJyNIrBXCTmm3HqF1Uj4c3SK/gbr5k875jnRRVdwPn
 VK3SyrtRLaxgmIqXYeZEg2fXYtSHqtrOGQETWX/lDkZtoheyQudf/bsrIs+F/1CdAZzk
 cacvZiUizrFT21xBj5AOMrwlxg44Scl93uzmz5a5Avn9kavtaPL6hVChICzv8NPJ+OGP
 SqrIAGs7nzbniREqXxjywiKqWqaVXb+zQYt+r9jLoPQqFuJk8vk7lKgp43tei1ZwfCaR
 syKA==
X-Gm-Message-State: AOAM533iT15bkOMomHQiZYcr1oQiXOhpRZ+YSYEE4WrS801hxbH1VxSV
 As3bXIchDZZN2zHa5nco8pYzNg==
X-Google-Smtp-Source: ABdhPJzQZ4uGbfqSQUBovRMfvP/hGloVqHliKut1DrE1HXdanUmTHhCCzsrvWpzoF6VDPB7uxgqAGg==
X-Received: by 2002:a1c:e389:: with SMTP id a131mr8436784wmh.46.1590751729031; 
 Fri, 29 May 2020 04:28:49 -0700 (PDT)
Received: from moi-limbo-9350.home
 (host86-151-121-39.range86-151.btcentralplus.com. [86.151.121.39])
 by smtp.gmail.com with ESMTPSA id h188sm6449053wmh.2.2020.05.29.04.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 04:28:48 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/2] target/arm: kvm: Support for KVM DABT with no valid ISS
Date: Fri, 29 May 2020 12:27:55 +0100
Message-Id: <20200529112757.32235-1-beata.michalska@linaro.org>
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Some of the ARMv7 & ARMv8 load/store instructions might trigger a data abort
exception with no valid ISS info to be decoded. The lack of decode info
makes it at least tricky to emulate the instruction which is one of the
(many) reasons why KVM will not even try to do so.

So far, if a guest made an attempt to access memory outside the memory slot,
KVM reported vague ENOSYS. As a result QEMU exited with no useful information
being provided or even a clue on what has just happened.

ARM KVM introduced support for notifying of an attempt to execute
an instruction that resulted in dabt with no valid ISS decoding info.
This still leaves QEMU to handle the case, but at least now it gives more
control and a start point for more meaningful handling of such cases.

This patchset relies on KVM to insert the external data abort into the guest.


Thanks for all the input on the previous version!
----------------------

v5:
 - Drop syncing vcpu regs in favour of calling kvm_put_vcpu_events directly
 - Fix decoding DFSC for LPAE case
 - Add/clarify comments
 - Switch to reporting error case failure when enabling the cap

v4:
 - Removing one of the patches as it is being picked-up separately
     target/arm: kvm: Inject events at the last stage of sync
 - Moving handling KVM issue to a separate patch
 - Minor changes wrt the review comments

v3:
 - Fix setting KVM cap per vm not per vcpu
 - Simplifying the handler to bare minimum with no default logging to address
   the potential risk of overflooding the host (adding support for rate
   limiting the logs turned out to be bit too invasive to justify the little
   add-on value from logs in this particular case)
 - Adding handling KVM bug (for small range of affected kernels):
   little bit of trade-off between what's reasonable and what's effective:
   aborting qemu when running on buggy host kernel

v2:
- Improving/re-phrasing messaging
- Dropping messing around with forced sync (@see [PATCH v2 1/2])
  and PC alignment

Beata Michalska (2):
  target/arm: kvm: Handle DABT with no valid ISS
  target/arm: kvm: Handle misconfigured dabt injection

 target/arm/cpu.h     |  3 ++
 target/arm/kvm.c     | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 target/arm/kvm32.c   | 35 ++++++++++++++++++++
 target/arm/kvm64.c   | 49 ++++++++++++++++++++++++++++
 target/arm/kvm_arm.h | 21 ++++++++++++
 5 files changed, 199 insertions(+), 1 deletion(-)

-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
