Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 9A25D302687
	for <lists+kvmarm@lfdr.de>; Mon, 25 Jan 2021 15:54:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1DC624B5E0;
	Mon, 25 Jan 2021 09:54:40 -0500 (EST)
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
	with ESMTP id ayGk3jl+IKjC; Mon, 25 Jan 2021 09:54:39 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E29484B5E1;
	Mon, 25 Jan 2021 09:54:38 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 4762D4B5DB
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Jan 2021 09:54:38 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XWkXZ3Tu5040 for <kvmarm@lists.cs.columbia.edu>;
 Mon, 25 Jan 2021 09:54:37 -0500 (EST)
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com
 [209.85.160.202])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 4E48F4B5DA
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Jan 2021 09:54:37 -0500 (EST)
Received: by mail-qt1-f202.google.com with SMTP id o20so4553397qtx.22
 for <kvmarm@lists.cs.columbia.edu>; Mon, 25 Jan 2021 06:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=/4PnAV+mhhjXNhLkdpio+RJoHfL25foHEOaPlQoz/QE=;
 b=NWB0nWRd64gJ2ZjxLt6crgU+r3JUbFMRZxpMdtoA20wnY8iLLCrM6zstQPRhuhIJWy
 yjonV63K0Z8R6LkQhHDo073EVRKvw4VRCgSCbI6Ic8yDQ06ciKWqfpY4GwyhL7jznF7F
 xAENORmQASBVeputBBKaogVlOPHlUhcpjc/OmuktgRN/uX+4FwTUbzpRl0/fDO/rwYzQ
 1d+U6YrHOSS9VBLYuBoQrISir0nCExsZTvw+1+vlbwvsDaOQgsP7bB/8XBDSxTIHtbNl
 lgZwjjM3QU06Ha/jQyengbhGCUW60tr0yMqjE4R7lE/YdbeyW17pSdfnJ7e4iJhAXjRO
 SnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=/4PnAV+mhhjXNhLkdpio+RJoHfL25foHEOaPlQoz/QE=;
 b=cKWMNayJCi56F7qce0dwP5QBhLecsAiqVA2bymLC0Gx9XMi35mxRK+lW8s5EXUjv/0
 F+i70HIYk52kEmyPU/w7Cgk5l9UB07UM0Uo0jrY2daHpw8YBWkt5lI8CghRG1rpn2IRI
 sohbi6QJQXBEJg4IpWmjA2dy0cgi4oC/fvZFfRxi0HZDl3NdNbqUbqOL2OMCkX2FPi7f
 pwU2nGsL0t09bSktpRo5+DCPV/g/g19OgRp3jACK/tdcHqrOaY++GkH+OOlfo9LIGma6
 WMGnfj3Lle6zZAdLi8Czb/qzUi9b1xdcxry+wzFWVXjdZAJyS5bsYHLySDBvzhvxZn3C
 CxtQ==
X-Gm-Message-State: AOAM533KHxQm+JglnmkW1F5A2xQALUIpaL2n3m3jtj35CREB++99VIs1
 8KjdNXoHe6d9mttbi+Cld+uRt9IgwEMy2jhAVvbvlcm7wU5LL5whHbYMTrEd8+LKmO1ItRZmwGD
 CTTG6tUXvGxBmRYNmHXKFVAHfpKnYJa4jDJFtKO98rpIRTEIx1x+5uOLNdzLADqf+Ux++Pg==
X-Google-Smtp-Source: ABdhPJzW3A8YhLAz8V2ijzySmwVfRRo+a1Rbs4+4rweK0rLdhD6l/dkP7a4P4U0BTNG4vNBRSTefqfXvWIA=
X-Received: from ascull.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1510])
 (user=ascull job=sendgmr) by 2002:a05:6214:c65:: with SMTP id
 t5mr1085338qvj.19.1611586476689; Mon, 25 Jan 2021 06:54:36 -0800 (PST)
Date: Mon, 25 Jan 2021 14:54:13 +0000
Message-Id: <20210125145415.122439-1-ascull@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 0/2] __do_hyp_init fix and tweak
From: Andrew Scull <ascull@google.com>
To: kvmarm@lists.cs.columbia.edu, kernel-team@android.com
Cc: maz@kernel.org
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

These apply on 5.11-rc4. The second is a fix for a clobbered register,
the first is more cosmetic.

Thanks, David, for helping with build and boot tests after my logistical
issues.

Andrew Scull (2):
  KVM: arm64: Simplify __kvm_hyp_init HVC detection
  KVM: arm64: Don't clobber x4 in __do_hyp_init

 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 35 +++++++++++++-----------------
 1 file changed, 15 insertions(+), 20 deletions(-)

-- 
2.30.0.280.ga3ce27912f-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
