Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 30C523F8DEF
	for <lists+kvmarm@lfdr.de>; Thu, 26 Aug 2021 20:37:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 90FDE4B102;
	Thu, 26 Aug 2021 14:37:30 -0400 (EDT)
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
	with ESMTP id pUpbdhPF9ZGU; Thu, 26 Aug 2021 14:37:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 985034B0D6;
	Thu, 26 Aug 2021 14:37:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 479FC4B0E2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Aug 2021 14:37:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mS3P0rgj5LNb for <kvmarm@lists.cs.columbia.edu>;
 Thu, 26 Aug 2021 14:37:24 -0400 (EDT)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com
 [209.85.166.178])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 3E74A4B08A
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Aug 2021 14:37:24 -0400 (EDT)
Received: by mail-il1-f178.google.com with SMTP id y3so4270982ilm.6
 for <kvmarm@lists.cs.columbia.edu>; Thu, 26 Aug 2021 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GAm5JijN4AEU/TD6X36+sfhDVS1/JaYRosKzetCw9x8=;
 b=PPK/6+9m5AQ/XQzVFR/xTbLDZ/dRbaed67pEoNOOMVIZEE9TZQd/gk5FMd0cUjk+Qy
 Rrif6nuaETT+ljaqlca+hXX40AeeBPw4T7UD1nQopn6c/n/lHFQ3a8s/9fgdJCqu2eMl
 GSSoRuXAy4Pm45MYm2sVaZ3USvODlJDxj96X9mXulrcvms+IF/UiHOBfSrjGqH45aDqe
 yOIawDyn9lubhVDh+CdABbSJIzwQ+Y30w1zYdRec9TbJsgp4oZt5vJR0atPImx4p0nLr
 vowSoEQUKN25nbcrV+A3hwwWLmvRnIon1buasyF7dOEfHpzPHDWoGh22n0geWmzd9Fxr
 xdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GAm5JijN4AEU/TD6X36+sfhDVS1/JaYRosKzetCw9x8=;
 b=tIVRsRXoZTlribXbBmaTVUq/1BT5sI7U04ZI0JqgW7pcExwqFkUV1HowsJLV5+XrCF
 IqgXLpDeJXp+0r2GTf2moaUAuZDSofi4VAbjvjJZlIDkktVRXTjX2eg5SOa6fA8hXW9f
 U6lj3KJX8mU1KFzO3tHqu4X+ABac+rNtY+tXeDKKF0f719vfS72Kt36Q6LjeTk15xWW7
 7mubtW8Mk/86Ct5lMYSFSugNV/Lb0N/RF3Z/VysMT3qK6oVDuY+sChN0U7/Spkb/jP1O
 T0bCc3CsFaWuAnIhMsUfrM+R0tejzY0CbI3l56rrVdJdewGfS+sFb1OotHDJ3ZxQaKxe
 9j5Q==
X-Gm-Message-State: AOAM53010sL1I6MoNKmxAeIjs1FlNLHWhLkUuHQRQbBvSYjk2JftlxMB
 Qe3rnFzLVpLlvX6atjxX7D3nAw==
X-Google-Smtp-Source: ABdhPJysNNpP1xRFngN1wyjZTHG7MW1CVdGV6b7GojI1wMIWgW3JN+jRUMXWcEvm/BNIa+DsEc6I3A==
X-Received: by 2002:a05:6e02:1846:: with SMTP id
 b6mr3880671ilv.264.1630003043324; 
 Thu, 26 Aug 2021 11:37:23 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com.
 [34.68.225.194])
 by smtp.gmail.com with ESMTPSA id b2sm2012209ioe.23.2021.08.26.11.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Aug 2021 11:37:22 -0700 (PDT)
Date: Thu, 26 Aug 2021 18:37:19 +0000
From: Oliver Upton <oupton@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 0/6] KVM: arm64: Implement PSCI SYSTEM_SUSPEND support
Message-ID: <YSffX53jVJsVzbv+@google.com>
References: <20210819223640.3564975-1-oupton@google.com>
 <CAOQ_QsgaACbcW276TAqrmq2E5ne-C2JiEDVGjVXg9-WRds8ZQA@mail.gmail.com>
 <8735qwpjhn.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8735qwpjhn.wl-maz@kernel.org>
Cc: kvm@vger.kernel.org, Peter Shier <pshier@google.com>,
 kvmarm@lists.cs.columbia.edu
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

On Thu, Aug 26, 2021 at 11:51:00AM +0100, Marc Zyngier wrote:
> > > Patch 1 is unrelated, and is a fix for "KVM: arm64: Enforce reserved
> > > bits for PSCI target affinities" on the kvmarm/next branch. Nothing
> > > particularly hairy, just an unused param.
> > 
> > Title line may not have been clear on this series, Patch 1 is a fix
> > for the PSCI CPU_ON series that's in kvmarm/next to suppress a
> > compiler warning.
> 
> I'm not getting this warning. What are you compiling with? In general,
> the compiler should shout about unused function parameters.

Gah, this is just with local tooling. I'm unable to repro using
GCC/Clang. I see that '-Wno-unused-parameter' is set alongside
'-Wunused' when W=1.

> > > Patch 5 is indirectly related to this series, and avoids compiler
> > > reordering on PSCI calls in the selftest introduced by "selftests: KVM:
> > > Introduce psci_cpu_on_test".
> > 
> > This too is a fix for the PSCI CPU_ON series. Just wanted to raise it
> > to your attention beyond the new feature I'm working on here.
> 
> I'm not sure this actually need fixing. The dependencies on the input
> and output will effectively prevent such reordering. That will
> definitely be a good cleanup though, but maybe not worth taking out of
> this series.

Yep, you're right. There's an obvious dependency in the test that
maintains program order. I realize that it is only the second test
(patch 6 in this series) where things get hairy.

Apologies for the noise.

--
Thanks,
Oliver
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
