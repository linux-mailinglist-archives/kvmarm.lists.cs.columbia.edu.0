Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 994EF23B716
	for <lists+kvmarm@lfdr.de>; Tue,  4 Aug 2020 10:52:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3349B4B617;
	Tue,  4 Aug 2020 04:52:38 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.799
X-Spam-Level: 
X-Spam-Status: No, score=0.799 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699] autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xfnZSeT2MfBS; Tue,  4 Aug 2020 04:52:38 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 30D5C4B633;
	Tue,  4 Aug 2020 04:52:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id C10734B617
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Aug 2020 04:52:35 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KlJdFO+dW-q0 for <kvmarm@lists.cs.columbia.edu>;
 Tue,  4 Aug 2020 04:52:34 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8B80F4B4C5
 for <kvmarm@lists.cs.columbia.edu>; Tue,  4 Aug 2020 04:52:34 -0400 (EDT)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@misterjones.org>)
 id 1k2sgS-00HL1G-R6; Tue, 04 Aug 2020 09:52:32 +0100
MIME-Version: 1.0
Date: Tue, 04 Aug 2020 09:52:32 +0100
From: Marc Zyngier <maz@misterjones.org>
To: Roja Eswaran <reswara1@binghamton.edu>
Subject: Re: Regarding Direct Injection of Virtual LPI in ARMv8 GICv4
In-Reply-To: <CAGTfD8bTpj914KrqY4RzCXQYqxTfGjVApyZRDAV9PrRBAx6+kA@mail.gmail.com>
References: <CAGTfD8bTpj914KrqY4RzCXQYqxTfGjVApyZRDAV9PrRBAx6+kA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <f5ba7437f4da266b0483c2872c2b6b41@misterjones.org>
X-Sender: maz@misterjones.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: reswara1@binghamton.edu, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvmarm@lists.cs.columbia.edu
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2020-08-03 19:09, Roja Eswaran wrote:
> CAN WE MODIFY TIMER INTERRUPTS OR IPI INTO VIRTUAL LPI AND DIRECTLY
> INJECT THEM IN VM?

[HTML email, all-caps... This is hard to take early in
  the morning, as I only had a single coffee]

No, you cannot route timer interrupts as VLPIs. These
interrupts are hard-wired into the core. For GICv4,
the only thing you can route as VLPI is LPIs.

With GICv4.1, you can directly inject SGIs them into
the guest, but only if you are prepared to forego the
active state.

You're welcome.

         M.
-- 
Who you jivin' with that Cosmik Debris?
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
