Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5A94B5A98
	for <lists+kvmarm@lfdr.de>; Mon, 14 Feb 2022 20:41:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 493EA49E39;
	Mon, 14 Feb 2022 14:41:06 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, T_DKIM_INVALID=0.01,
	URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MKIiPvKxnewA; Mon, 14 Feb 2022 14:41:06 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7BE4549E2A;
	Mon, 14 Feb 2022 14:41:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 863C549E16
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Feb 2022 14:41:03 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WyiBprxuUU5Y for <kvmarm@lists.cs.columbia.edu>;
 Mon, 14 Feb 2022 14:41:01 -0500 (EST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id B1FF349E10
 for <kvmarm@lists.cs.columbia.edu>; Mon, 14 Feb 2022 14:41:01 -0500 (EST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6D46FB81676;
 Mon, 14 Feb 2022 19:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D63C340EE;
 Mon, 14 Feb 2022 19:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644867659;
 bh=1o5yberQtulpwwBd/plhZbg28raYj8ZfYwhHG4ZSxto=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bfTmgXXadlMCUzdd7Ex9U0v4ZkThqvVNxUWIhRWKBci+ySORwLpe9TAkTqhaFf3Qk
 1WMTZqraPlhucWRNPM4MZ60GCr+zWFIpPBXaB6+hKiWZYzRwVqGFHl8JcKoy98W8TG
 mo0UOx3zq+Bgtd+b3qMXKwzcltJ09obZjRpHghs0T5eoUli5g/yqYY4f5+ouawkRF+
 M8VAOzYNjCMEzwYnWV4Ng3303UUz+zeNYDUlOHoTQeIG37x2hHunV/jtDPdwB38CJK
 NBxo3dsItnggCiRS6UNL95q0cO0pxM8NnFMVRj+jva5AZ00ouY3FkVthW1udGl7MIF
 yU90mBm8XWB8Q==
Date: Mon, 14 Feb 2022 19:40:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v11 06/40] arm64/sme: Provide ABI documentation for SME
Message-ID: <YgqwRIIi7UZzOOR2@sirena.org.uk>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-7-broonie@kernel.org>
 <YgVaTounTtunlGU6@arm.com> <YgVrbc4fFrA0Vjh2@sirena.org.uk>
 <YgaWmP+P7v9b2lLz@arm.com> <YganZni933HbRTmO@sirena.org.uk>
 <YgqdTv3Hq+H76Ml7@arm.com>
MIME-Version: 1.0
In-Reply-To: <YgqdTv3Hq+H76Ml7@arm.com>
X-Cookie: Am I in GRADUATE SCHOOL yet?
Cc: Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
 Will Deacon <will@kernel.org>, Luis Machado <luis.machado@arm.com>,
 Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Alan Hayward <alan.hayward@arm.com>,
 Shuah Khan <shuah@kernel.org>, kvmarm@lists.cs.columbia.edu,
 Salil Akerkar <Salil.Akerkar@arm.com>
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
Content-Type: multipart/mixed; boundary="===============4895609108928880463=="
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu


--===============4895609108928880463==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m90JMmwjd1FkMFl4"
Content-Disposition: inline


--m90JMmwjd1FkMFl4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 14, 2022 at 06:19:58PM +0000, Catalin Marinas wrote:
> On Fri, Feb 11, 2022 at 06:13:58PM +0000, Mark Brown wrote:

> > We could preserve PSTATE.SM, though since all the other register state
> > for streaming mode is shared with SVE I would expect that we should be
> > applying the SVE discard rules to it and there is therefore no other
> > state that should be retained.

> So when clearing PSTATE.SM, the streaming SVE regs become unknown (well,
> the wording is a bit more verbose). I think this fits well with the
> proposal to drop the streaming SVE state entirely on syscalls.

They're preserved or zeroed, yes.

> The ZA state I think is not affected by the PSTATE.SM change (early
> internal SME specs were listing this as unknown after SM clearing but I
> can't find it in the latest spec). However, after the syscall, the user
> won't be able to execute SME instruction until turning on PSTATE.SM
> again.

Yes, ZA is preserved unless PSTATE.ZA is disabled.  There are some
instructions that can be used to interact with it outside of streaming
mode, a subset of the instructions for loading and storing values in ZA.

> Would the libc wrappers preserve PSTATE.SM? What I find a bit confusing
> is that we only partially preserve some state while in streaming mode -
> the ZA registers but not the SVE ones.

I would expect that libc wrappers would expect to be called with
streaming mode already disabled - that's what default functions in the
PCS expect, and since without FA64 enabled a huge proportion of FPSIMD
instructions and some SVE instructions become undefined standard code
could easily generate traps if it uses those instructions for anything.
I wouldn't expect that libc would explicitly disable SME itself in
standard configurations.

>                                        Is the user more likely to turn
> PSTATE.SM on for ZA processing or for SVE? If the former, we don't want
> to unnecessarily save/restore some SVE state that the user doesn't care

It's expected that any active work with ZA will require enabling
streaming mode, you can't do any actual computation with it without
doing so and most of the work with ZA will involve using the streaming
mode SVE registers as part of the computation (eg, collecting results in
a Z register, or doing an operation to a ZA tile using the contents of a
Z register as an operand).

It is also expected that some applications may prefer to execute what is
mainly a SVE workload in streaming mode, as well as any performance
relevant differences in the implementation choices the hardware makes it
is likely that some systems will have vector lengths available in
streaming mode that are otherwise unavailable (eg, you might have PEs
with 128 bit FPSIMD/SVE units and a 512 bit SMCU).

I don't have a good handle on which sort of usage is going to be more
common, and I expect that the answer is going to be very system
dependent varying based on both the mix of applications running on the
system at any given moment and the capabilities of the standard and
streaming mode floating point implementations that the system has.

However the existing syscall ABI for the Z and P registers (which is all
the SVE register state, FFR is a magic P register) means that unless we
treat streaming mode differently to non-streaming mode we'll be
discarding whatever state is there anyway so userspace by definition
shouldn't have anything in there it expects to be preserved when it does
a syscall.  I'd rather not introduce an ABI that guarantees that we
preserve the streaming mode SVE register state in cases where we discard
(or can discard) the non-streaming SVE register state, that's both going
to be more complicated to implement and more likely to cause unexpected
differences that trip userspace up.

> about (can we even trap SVE instructions independently of SME while in
> streaming mode?).

I'd need to check through but I don't believe so.

> I'd find it clearer if we preserved PSTATE.SM and, w.r.t. the streaming
> SVE state, we somewhat follow the PCS and not restore the regs (input
> from the libc people welcomed).

Like I say we can do that easily enough, it's not something I expect to
ever come up in practical usage though.

> > Having said that as with ZA userspace can just exit streaming mode to
> > avoid any overhead having it enabled introduces and the common case is
> > expected to be that it will have done so due to the PCS, it should be an
> > extremely rare case - unlike keeping ZA active there doesn't seem to be
> > any case where it would be sensible to want to do this and the PCS means
> > you'd have to actively try to do so.

> IIUC, the PCS introduced the notion of streaming-compatible functions
> that preserve the SM bit. If they are non-streaming, SM should be 0 on

Yes, it isn't the default though.

> entry. It would be nice if we put the syscalls in one of these
> categories, so either mandate SM == 0 on entry or preserve (the latter
> being easier, I think, I haven't looked at what it takes to save/restore
> the streaming SVE state; I may change my mind after reviewing at the
> other patches).

The streaming SVE state is identical to the SVE state with the exception
of the FFR predicate register which is not present unless FA64 is
available in the system and enabled and the separatly configured vector
length.

It's sounding like we may as well just preserve SM, it shouldn't come up
that often anyway and if it causes performance problems we can probably
optimise it, and/or userspace can simply just not do that.  Like I say I
don't have particularly strong feelings, the current behaviour was just
the easiest thing to implement and it doesn't seem like there is a use
case.  This is fine by me, I can do that for the next version.

[fork()/clone() behaviour]
> (few hours later) I think instead of singling out fork() (clone3()
> actually), we can just say that new tasks (process/thread) always start
> with PSTATE.ZA == 0, PSTATE.SM == 0 (tbd for this) and TPIDR2_EL0 == 0
> irrespective of any clone3() flags (even CLONE_SETTLS). The C library
> will have to implement the lazy ZA saving in the parent before the
> syscall and the child will automatically recover the state if it follows
> the PCS.

Works for me, I think forcing the userspace to consider this is going to
work out more robust.

--m90JMmwjd1FkMFl4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIKsEMACgkQJNaLcl1U
h9CY5wf8CSOiz63Wqwe1/Yuqmw2EskUr3T5VUQjZG17xtbYsMIbDQTwuK0PL9sr+
5pXdIYsvcDH0+3Su8LL6+WKQYfGbLBli9b5nK6yWoQME6tP7E6fD51eJg6TiXvaZ
0ujB61I5aGOHxLDYnpZJmeKKiJplFdTYzunW6PyCGgQqU8Sya84bCNNPP1PQj3vm
s4MDXEl9Ypif4go0ptR3Dkb6hJhayvCfTv9CxJ8KoeQxqrqwvlAmYfmKpCBRGXs9
i2EN621MQidF9GdhiwKfEhAvJZRM3zdf4vacdtRpbSLys3wRYPFMSQ1/N3t2BxMw
6+PSEUDzijTYJ+PxbdqIREE9kEH/pA==
=8xaj
-----END PGP SIGNATURE-----

--m90JMmwjd1FkMFl4--

--===============4895609108928880463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

--===============4895609108928880463==--
