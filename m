Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id F2C9C5EBF90
	for <lists+kvmarm@lfdr.de>; Tue, 27 Sep 2022 12:18:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E92884B736;
	Tue, 27 Sep 2022 06:18:13 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mzfRlvi8KG2K; Tue, 27 Sep 2022 06:18:13 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AF20B4B6E2;
	Tue, 27 Sep 2022 06:18:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1D0E34B6C7
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Sep 2022 06:18:11 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 71KLEygBsxtB for <kvmarm@lists.cs.columbia.edu>;
 Tue, 27 Sep 2022 06:18:09 -0400 (EDT)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id D40F44B1B4
 for <kvmarm@lists.cs.columbia.edu>; Tue, 27 Sep 2022 06:18:09 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2D509B81A0D;
 Tue, 27 Sep 2022 10:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F1EC433D6;
 Tue, 27 Sep 2022 10:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664273886;
 bh=H/HZ+8Yn/BiaXmw/8d1VR0gleRQhWzamBner0vTDoWc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=DGpqE+yyCTkC0ISYppAy954jrFGx++xsqBqQX6E48GFXhLByX9Xck+RIWjTLzztn5
 gkGZBxgjzCcQibYUQGHjRLx1InlistGkQ8hzAjifhoDmnlKgokqQXWSsbu8lFLx4CN
 Oock7os8ojEAXXh35ySF3E1ow4QQqTkS6ZiheYjv8ZykFFCjoF10S6xI/ef6Sz2Jb6
 JM1N6zkjX0+F4Ge2ycxMKSF+DQcFe/5DdX++1Kga9HWUI3TgdmiV7mn/JA7Yk1H7vP
 zrnHIvEOTjOXJsKR34mvW5y0HVrhtwiSW5pqtUfmFoNzu9S+0r8/WI5ud5h7F4RA8v
 VrkokeQGxfTLg==
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=goblin-girl.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1od7fA-00Cwgn-IO;
 Tue, 27 Sep 2022 11:18:04 +0100
Date: Tue, 27 Sep 2022 06:18:03 -0400
Message-ID: <86zgel6rz8.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Mingwei Zhang <mizhang@google.com>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH] KVM: arm64: Cleanup the __get_fault_info() to take out
 the code that validates HPFAR
In-Reply-To: <YzKGqLzjv0I/gkMi@google.com>
References: <20220927002715.2142353-1-mizhang@google.com>
 <YzKGqLzjv0I/gkMi@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: mizhang@google.com, oliver.upton@linux.dev,
 catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
 alexandru.elisei@arm.com, suzuki.poulose@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
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

On Tue, 27 Sep 2022 01:14:16 -0400,
Oliver Upton <oliver.upton@linux.dev> wrote:
> 
> Hi Mingwei,
> 
> On Tue, Sep 27, 2022 at 12:27:15AM +0000, Mingwei Zhang wrote:
> > Cleanup __get_fault_info() to take out the code that checks HPFAR. The
> > conditions in __get_fault_info() that checks if HPFAR contains a valid IPA
> > is slightly messy in that several conditions are written within one IF
> > statement acrossing multiple lines and are connected with different logical
> > operators. Among them, some conditions come from ARM Spec, while others
> 						   ^~~~~~~~
> 
> Call it the ARM ARM or Arm ARM, depending on what stylization you
> subscribe to :)
> 
> > come from CPU erratum. This makes the code hard to read and
> > difficult to extend.
> 
> I'd recommend you avoid alluding to future changes unless they're posted
> on the mailing list.

Honestly, I'd refrain from such changes *unless* they enable something
else. The current code is well understood by people hacking on it, and
although I don't mind revamping it, it has to be for a good reason.

I'd be much more receptive to such a change if it was a prefix to
something that actually made a significant change.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
