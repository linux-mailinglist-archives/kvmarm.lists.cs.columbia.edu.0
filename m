Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 622795EF9EA
	for <lists+kvmarm@lfdr.de>; Thu, 29 Sep 2022 18:13:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7126649F2C;
	Thu, 29 Sep 2022 12:13:28 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@chromium.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xTfLJmDX2uxg; Thu, 29 Sep 2022 12:13:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1DCF843C96;
	Thu, 29 Sep 2022 12:13:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A37FF40AEB
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Sep 2022 12:13:25 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CWazKcVgnCUa for <kvmarm@lists.cs.columbia.edu>;
 Thu, 29 Sep 2022 12:13:24 -0400 (EDT)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com
 [209.85.166.182])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 431764089C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Sep 2022 12:13:24 -0400 (EDT)
Received: by mail-il1-f182.google.com with SMTP id h14so932730ila.12
 for <kvmarm@lists.cs.columbia.edu>; Thu, 29 Sep 2022 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=2/Sh/v9WLQ5DacoeCo5LR01Tpb6RXV73Us2dj8jMEgg=;
 b=Fw7CFHoqbIneHRGW1eSzygncQww0Nzr+13COSVf/LuaJXbMsGVbWr2JwANb/NZY7cw
 IpMmrX8xtoPKi0vCSFChe1T9LUihF8v98KKbZkQqp5p+Fdl7hypt3C2YYhClYj9wpsT/
 ru/Gk4dlWn5p2GGuFVngT45Qc6okNOm50vGB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=2/Sh/v9WLQ5DacoeCo5LR01Tpb6RXV73Us2dj8jMEgg=;
 b=FRK+2+3txhRIcb0G9EOkc+mgi4IlR4WBIu1ev1KWTQVg6h1pCUDnVpbOPzuGVpbcIC
 Gu6UaDjjaJtuzY19a0u76OAuT1W5A8BmNmunYfRSWtXwG789MxUgljwl0b1KMFTGt2id
 2x+gsuZncjLu9hRSYLSaq5kSn6TBKLteZA2ukskZ4snZ6mFiXPdQ/RVlkp07X1AsevQX
 HhYfHOyOwwlzd7VAsqbtblr2l0iLuUpMr4Q0AJUK0QO3rJpodtJCimMZN4z3pV3ixRni
 oOZo4+Eqr/ZrSZrdFlCIv/1/kCCdwFTOBKS6uK1eBqqGTjjtZKNQFTPqoZkNruOhkmUX
 WrsA==
X-Gm-Message-State: ACrzQf2FJsM27VECf8m340JHM4LLxfPGTKVsXzHgcGdHMDvkt3nWJDHn
 ArIKzFptl4Sy8kd+qFZ3KfQlQN7jNhgbHjsCgA2HEw==
X-Google-Smtp-Source: AMsMyM5Xp6QV/gtVq6nfq38rfm0HFlPCG++1YgV5/2Las3rfpesEcOIm0y5DnS+EK3kcktlg/qc98KnIYXyEMrRhv6E=
X-Received: by 2002:a05:6e02:b45:b0:2f8:ab79:fc70 with SMTP id
 f5-20020a056e020b4500b002f8ab79fc70mr1980049ilu.214.1664468003604; Thu, 29
 Sep 2022 09:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220920082005.2459826-1-denik@chromium.org>
 <20220922053145.944786-1-denik@chromium.org>
 <87h70zk83g.wl-maz@kernel.org>
 <CADDJ8CW0QgHtp1rwk=ZqrcuWZ4_L8KQh26VaEfcBQS0Tx9+ZYg@mail.gmail.com>
 <CAH=Qcsi3aQ51AsAE0WmAH9VmpqjOaQQt=ru5Nav4+d8F3fMPwQ@mail.gmail.com>
In-Reply-To: <CAH=Qcsi3aQ51AsAE0WmAH9VmpqjOaQQt=ru5Nav4+d8F3fMPwQ@mail.gmail.com>
From: Denis Nikitin <denik@chromium.org>
Date: Thu, 29 Sep 2022 09:13:12 -0700
Message-ID: <CADDJ8CXObkhMvOx+L29awjtt7tiaTWxFrRxOmhUqvzku1wswHw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: arm64: nvhe: Fix build with profile optimization
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Manoj Gupta <manojgupta@google.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

Hi Marc,

Please let me know what you think about this approach.

Thanks,
Denis

On Thu, Sep 22, 2022 at 11:04 PM Manoj Gupta <manojgupta@google.com> wrote:
>
>
>
> On Thu, Sep 22, 2022 at 10:01 PM Denis Nikitin <denik@chromium.org> wrote:
>>
>> Hi Mark,
>>
>> On Thu, Sep 22, 2022 at 3:38 AM Marc Zyngier <maz@kernel.org> wrote:
>> >
>> > I was really hoping that you'd just drop the flags from the CFLAGS
>> > instead of removing the generated section. Something like:
>> >
>> > diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
>> > index b5c5119c7396..e5b2d43925b4 100644
>> > --- a/arch/arm64/kvm/hyp/nvhe/Makefile
>> > +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
>> > @@ -88,7 +88,7 @@ quiet_cmd_hypcopy = HYPCOPY $@
>> >
>> >  # Remove ftrace, Shadow Call Stack, and CFI CFLAGS.
>> >  # This is equivalent to the 'notrace', '__noscs', and '__nocfi' annotations.
>> > -KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
>> > +KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI) -fprofile-sample-use, $(KBUILD_CFLAGS))
>> >
>> >  # KVM nVHE code is run at a different exception code with a different map, so
>> >  # compiler instrumentation that inserts callbacks or checks into the code may
>>
>> Sorry, I moved on with a different approach and didn't explain the rationale.
>>
>> Like you mentioned before, the flag `-fprofile-sample-use` does not appear
>> in the kernel. And it looks confusing when the flag is disabled or filtered out
>> here. This was the first reason.
>>
>> The root cause of the build failure wasn't the compiler profile guided
>> optimization but the extra metadata in SHT_REL section which llvm injected
>> into kvm_nvhe.tmp.o for further link optimization.
>> If we remove the .llvm.call-graph-profile section we fix the build and avoid
>> potential problems with relocations optimized by the linker. The profile
>> guided optimization will still be applied by the compiler.
>>
>> Let me know what you think about it.
>>
>> >
>> > However, I even failed to reproduce your problem using LLVM 14 as
>> > packaged by Debian (if that matters, I'm using an arm64 build
>> > machine). I build the kernel with:
>> >
>> > $ make LLVM=1 KCFLAGS=-fprofile-sample-use -j8 vmlinux
>> >
>> > and the offending object only contains the following sections:
>> >
>
>
> Just some comments based on my ChromeOS build experience.
>
> fprofile-sample-use needs the profile file name argument to read the pgo data from
> i.e. -fprofile-sample-use=/path/to/gcov.profile.
>
> Since the path to filename can change, it makes filtering out more difficult.
> It is certainly possible to find and filter the exact argument by some string search of KCFLAGS.
> But passing  -fno-profile-sample-use is easier and less error prone which I believe the previous patch version tried to do.
>
>
>> > arch/arm64/kvm/hyp/nvhe/kvm_nvhe.tmp.o:     file format elf64-littleaarch64
>> >
>> > Sections:
>> > Idx Name          Size      VMA               LMA               File off  Algn
>> >   0 .hyp.idmap.text 00000ae4  0000000000000000  0000000000000000  00000800  2**11
>> >                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>> >   1 .hyp.text     0000e988  0000000000000000  0000000000000000  00001800  2**11
>> >                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>> >   2 .hyp.data..ro_after_init 00000820  0000000000000000  0000000000000000  00010188  2**3
>> >                   CONTENTS, ALLOC, LOAD, DATA
>> >   3 .hyp.rodata   00002e70  0000000000000000  0000000000000000  000109a8  2**3
>> >                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>> >   4 .hyp.data..percpu 00001ee0  0000000000000000  0000000000000000  00013820  2**4
>> >                   CONTENTS, ALLOC, LOAD, DATA
>> >   5 .hyp.bss      00001158  0000000000000000  0000000000000000  00015700  2**3
>> >                   ALLOC
>> >   6 .comment      0000001f  0000000000000000  0000000000000000  00017830  2**0
>> >                   CONTENTS, READONLY
>> >   7 .llvm_addrsig 000000b8  0000000000000000  0000000000000000  0001784f  2**0
>> >                   CONTENTS, READONLY, EXCLUDE
>> >   8 .altinstructions 00001284  0000000000000000  0000000000000000  00015700  2**0
>> >                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>> >   9 __jump_table  00000960  0000000000000000  0000000000000000  00016988  2**3
>> >                   CONTENTS, ALLOC, LOAD, RELOC, DATA
>> >  10 __bug_table   0000051c  0000000000000000  0000000000000000  000172e8  2**2
>> >                   CONTENTS, ALLOC, LOAD, RELOC, DATA
>> >  11 __kvm_ex_table 00000028  0000000000000000  0000000000000000  00017808  2**3
>> >                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>> >  12 .note.GNU-stack 00000000  0000000000000000  0000000000000000  00027370  2**0
>> >                   CONTENTS, READONLY
>> >
>> > So what am I missing to trigger this issue? Does it rely on something
>> > like PGO, which is not upstream yet? A bit of handholding would be
>> > much appreciated.
>>
>> Right, it relies on the PGO profile.
>> On ChromeOS we collect the sample PGO profile from Arm devices with
>> enabled CoreSight/ETM. You can find more details on ETM at
>> https://www.kernel.org/doc/Documentation/trace/coresight/coresight.rst.
>>
>> https://github.com/Linaro/OpenCSD/blob/master/decoder/tests/auto-fdo/autofdo.md
>> contains information about the pipeline of collecting, processing, and applying
>> the profile.
>>
>
> Generally the difficult part is in collecting a good matching profile for the workload.
> So I think this patch is better than previous since it still keeps the compiler optimization for the hot code paths
> in the file but removes the problematic section.
>
> Thanks,
> Manoj
>
>
>>
>> >
>> > Thanks,
>> >
>> >         M.
>> >
>> > --
>> > Without deviation from the norm, progress is not possible.
>>
>> Thanks,
>> Denis
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
