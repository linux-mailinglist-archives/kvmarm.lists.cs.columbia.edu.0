Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 3B30820C2C9
	for <lists+kvmarm@lfdr.de>; Sat, 27 Jun 2020 17:26:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 637A54B38A;
	Sat, 27 Jun 2020 11:26:22 -0400 (EDT)
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
	with ESMTP id HSRQejJ3Hgrh; Sat, 27 Jun 2020 11:26:22 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3DBF74B38D;
	Sat, 27 Jun 2020 11:26:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4DC7B4B382
 for <kvmarm@lists.cs.columbia.edu>; Sat, 27 Jun 2020 11:26:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1emJORxzIP5D for <kvmarm@lists.cs.columbia.edu>;
 Sat, 27 Jun 2020 11:26:19 -0400 (EDT)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0E9454B378
 for <kvmarm@lists.cs.columbia.edu>; Sat, 27 Jun 2020 11:26:19 -0400 (EDT)
Received: by mail-wr1-f67.google.com with SMTP id f7so9274924wrw.1
 for <kvmarm@lists.cs.columbia.edu>; Sat, 27 Jun 2020 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=/m5mkGKgtE7TjZA080Li1qh2nYl8NNeDGiBLeOpwFJo=;
 b=kNVe3GuFiUeXwCsfG2Eq5K2BglY0ES0Gr/INHyYw6t8an42v+tbRggl/WTBc64RC/n
 6T0lJSR+QuMzKrhlQW8v4GQ8c6u9qRipzWcgcDUvxp6/jBwZ0b8WGkUYkj5jlcWv0yz/
 8apa/3iII9C6wrB6j/YNT7tewL7OUH3jUdxfOVZczIXyhRHyy6wLGdd6oLi23esux+jm
 VY0hRKOlYHB0lx/I5tWX9uzxDjpMYFGZjS7/sD3itt80DgFyLryPy5OmHHHqMB2zAATv
 s2SytPEIHifhLCnVIFKc7yJaPAfXrAuR6QlWQzwN26C7q8bZhzlfgEt2ayhejF8GMhC0
 AO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=/m5mkGKgtE7TjZA080Li1qh2nYl8NNeDGiBLeOpwFJo=;
 b=Upm7GpMLXxpelCbF6Tu77a8+BLa6xwBd+3dSCyaT4k1XW+bJ/0tXmHuBGx6WkJZYhp
 afEhuddPHYFwJjnpKO8D+DYVnmbXfUTR3auEAV+kLw5UHbJGzi3Ch0j9cJk8gl+kcHWp
 PZSG+1awatTIpJur5dnaljN6gulQ2ZKkPD4J+lveo83xEuxyI6M2fdjJNPURMlo/Wo4b
 lXz7/rLLNdBiMr3rHE8lwBwb6g9jjHB0awFVuJI0oiE7iJ7GlWOYmbfjGuF9Ciu55sG6
 zNjreh/Nwn/REaGFn5yqpFNbgU5s27b9CynVjz0m53qJHQuZCP7v/kv0Cvs+NrtFuY1W
 zpNQ==
X-Gm-Message-State: AOAM5321pxWAcUgs452ZSYY1Ot0uIZI07vq2tW4GWGU2XErwOtOWEGvq
 dGFPIEvKw4G1oTAeIDOOGOwC+g==
X-Google-Smtp-Source: ABdhPJytZwJgPWrPXLFY8FUO8YhnxyDvbSYj2WOOTlZDTwlkA22oezC1GI4qqG3pYYNTR2laWiDCDg==
X-Received: by 2002:a5d:43d2:: with SMTP id v18mr8780574wrr.196.1593271577800; 
 Sat, 27 Jun 2020 08:26:17 -0700 (PDT)
Received: from moi-limbo-9350.home (host-92-18-20-3.as13285.net. [92.18.20.3])
 by smtp.gmail.com with ESMTPSA id
 c6sm20965438wma.15.2020.06.27.08.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2020 08:26:17 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 0/2] target/arm: kvm: Support for KVM DABT with no valid ISS
Date: Sat, 27 Jun 2020 16:25:54 +0100
Message-Id: <20200627152556.7391-1-beata.michalska@linaro.org>
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


----------------------
v7:
 - Rephrasing the comment regarding abort injection and vcpu synchronization
 - switching to struct initialization instead of memset

v6:
 - replacing calling kvm_put_vcpu_events with an actual ioctl call
 - making the handler function static

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

 target/arm/cpu.h     |  2 ++
 target/arm/kvm.c     | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 target/arm/kvm32.c   | 34 +++++++++++++++++++++
 target/arm/kvm64.c   | 49 ++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h | 10 ++++++
 5 files changed, 180 insertions(+), 1 deletion(-)

-- 
2.7.4

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
