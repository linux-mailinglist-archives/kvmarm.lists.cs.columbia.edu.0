Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id AF9E4650E95
	for <lists+kvmarm@lfdr.de>; Mon, 19 Dec 2022 16:27:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id F3CC44B8C6;
	Mon, 19 Dec 2022 10:27:25 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -6.789
X-Spam-Level: 
X-Spam-Status: No, score=-6.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_HI=-5, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f+kFPDW1QHHV; Mon, 19 Dec 2022 10:27:25 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A30224B8BC;
	Mon, 19 Dec 2022 10:27:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3C5E54B8B7
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Dec 2022 10:27:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5cfy7S2c-pbN for <kvmarm@lists.cs.columbia.edu>;
 Mon, 19 Dec 2022 10:27:22 -0500 (EST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 0C7F44B871
 for <kvmarm@lists.cs.columbia.edu>; Mon, 19 Dec 2022 10:27:21 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0E27061011;
 Mon, 19 Dec 2022 15:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D110BC433EF;
 Mon, 19 Dec 2022 15:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671463640;
 bh=JMW0b8vWlwPAZKdyQQxW3qognqY1rfXtk72EWUCOkXo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=aPk4RHrGseOyH9skuJulVohV+CFyLrm+dOlxl0w8315MBSQSCHaW0XXH3pbwSIsA3
 7xe8mcgfOWEO9fQGfYgZ+Eg4x+v2TPw8GxAsmri0r5ofYbEJV8hdmTfObcKUpGLnpy
 LAfECG1u9g6UbaD7atsRqh/1KqNqxwHMmcqOaT0Q3sZDyWMqhuZ7I9S8azAtrx009t
 YuxzvceHLMkWp0I+mCvPDeX4gEDsWSDB0e2jkvST63IpWfLauI35bYOJmBYHZagq2c
 uAlfD2VE6H2r0v9kBEh05Na55SW9US+6EHavCLR9umx4B9xcGihvWR0QXBxg6nhoH4
 JJIxCY0tDw3SA==
Received: from sofa.misterjones.org ([185.219.108.64]
 helo=goblin-girl.misterjones.org)
 by disco-boy.misterjones.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <maz@kernel.org>) id 1p7I2v-00DglG-TZ;
 Mon, 19 Dec 2022 15:27:18 +0000
Date: Mon, 19 Dec 2022 15:27:17 +0000
Message-ID: <86o7rzpg6i.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/7] arm64/sysreg: Convert CCSIDR_EL1 to automatic
 generation
In-Reply-To: <Y6B8fzaFSwmJ5VC1@sirena.org.uk>
References: <20221218051412.384657-1-akihiko.odaki@daynix.com>
 <20221218051412.384657-2-akihiko.odaki@daynix.com>
 <87cz8hez0i.wl-maz@kernel.org>
 <1ef32b0c-6cee-75f7-e1e0-ede1f5b9a016@daynix.com>
 <87bko0g8m2.wl-maz@kernel.org> <Y6B8fzaFSwmJ5VC1@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: broonie@kernel.org, akihiko.odaki@daynix.com,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 mathieu.poirier@linaro.org, oliver.upton@linux.dev, suzuki.poulose@arm.com,
 alexandru.elisei@arm.com, james.morse@arm.com, will@kernel.org,
 catalin.marinas@arm.com, asahi@lists.linux.dev, alyssa@rosenzweig.io,
 sven@svenpeter.dev, marcan@marcan.st
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin <marcan@marcan.st>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Will Deacon <will@kernel.org>,
 Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
 kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
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

On Mon, 19 Dec 2022 15:00:15 +0000,
Mark Brown <broonie@kernel.org> wrote:
> 
> [1  <text/plain; us-ascii (7bit)>]
> On Sun, Dec 18, 2022 at 01:11:01PM +0000, Marc Zyngier wrote:
> > Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> 
> > > arch/arm64/tools/gen-sysreg.awk does not allow a hole and requires all
> > > bits are described hence these descriptions. If you have an
> > > alternative idea I'd like to hear.
> 
> > I'd simply suggest creating an UNKNOWN field encompassing bits
> > [21:28]. Alternatively, feel free to try the patch below, which allows
> > you to describe these 4 bits as "Unkn	31:28", similar to Res0/Res1.
> 
> I agree, where practical we should add new field types and other
> features as needed rather than trying to shoehorn things into what the
> tool currently supports.  It is very much a work in progress which can't
> fully represent everything in the spec yet.  For things like the
> registers with multiple possible views it's much more effort which
> shouldn't get in the way of progress on features but with something like
> this just updating the tool so we can match the architecture spec is the
> right thing.

I was tempted to add a Namespace tag that wouldn't generate the sysreg
#defines, but only generate the fields with a feature-specific
namespace. For example:

Sysreg	CCSIDR_EL1	3	1	0	0	0
Res0	63:32
Unkn	31:28
Field	27:13	NumSets
Field	12:3	Associativity
Field	2:0	LineSize
EndSysreg

Namespace CCIDX CCSIDR_EL1
Res0	63:56
Field	55:32	NumSets
Res0	31:25
Field	24:3	Associativity
Field	2:0	LineSize
EndSysreg

the later generating:

#define CCIDR_EL1_CCIDX_RES0		(GENMASK(63, 56) | GENMASK(31, 25))
#define	CCIDR_EL1_CCIDX_NumSets		GENMASK(55, 32)
#define	CCIDR_EL1_CCIDX_Associativity	GENMASK(24, 3)
#define CCIDR_EL1_CCIDX_LineSize	GENMASK(2, 0)

Thoughts?

> 
> > Define an 'Unkn' field type modeled after the Res0/Res1 types
> > to allow such description. This allows the generation of
> 
> I'd be tempted to spell out Unknown fully since Unkn is not such a
> common abbreviation but I can see the desire to keep the name shorter
> and it doesn't really matter so either way:
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

Yeah, this stuff is write-only most of the time, and I like my fields
aligned if at all possible.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
