Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 4535A3C782C
	for <lists+kvmarm@lfdr.de>; Tue, 13 Jul 2021 22:48:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AF6304B08D;
	Tue, 13 Jul 2021 16:48:04 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.209
X-Spam-Level: 
X-Spam-Status: No, score=0.209 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bIRNBGXWg+kJ; Tue, 13 Jul 2021 16:48:04 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 825904A551;
	Tue, 13 Jul 2021 16:48:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8C7DF4A4BE
 for <kvmarm@lists.cs.columbia.edu>; Tue, 13 Jul 2021 16:48:02 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kzPq+m1ujGaZ for <kvmarm@lists.cs.columbia.edu>;
 Tue, 13 Jul 2021 16:48:01 -0400 (EDT)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 7906449F5F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 13 Jul 2021 16:48:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626209281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edgULd724qxW2wczl2lL2drDkUNp/TtLehg+wvSDn60=;
 b=Km7/Ni0OrKc8z1HJ+HXACh6hets7CcM3aLdqYvksZebOJunQC2RQ2q9j0j8bRXTGzyI+uA
 5pa+fuv+ua2BvfoNCDiHk687jWw2A4GbXRw8VhqoJYPV27Oq3HEGiDIGRnPm+3Y1mypVQy
 rn3IAMb6YVFGhI5ngX4DVJJJzaVxLx8=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462--YDt2YGGPgOXKGLSjncdbg-1; Tue, 13 Jul 2021 16:47:57 -0400
X-MC-Unique: -YDt2YGGPgOXKGLSjncdbg-1
Received: by mail-il1-f198.google.com with SMTP id
 i11-20020a056e02004bb029020269661e11so14310076ilr.13
 for <kvmarm@lists.cs.columbia.edu>; Tue, 13 Jul 2021 13:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=edgULd724qxW2wczl2lL2drDkUNp/TtLehg+wvSDn60=;
 b=PX6UHdd7wbFvVXe9Mp6cvPfqMiQgZOjhzHIdE09jYWggy58MOq7Zdnrw3m0U9vaqUm
 jZ5P12GMfiiH58XtmPmJSu+d3EmTbuNSUHWOWZXMa50QQka6XvcgkCb+7UtJdu74fiY2
 dwZ8ce2Aqp1/b6I0/2MGIvaQ/akoe9xa1J9CJM+YIUq6TMVOm7k1uWre1OY30vZW9Bql
 wCqWS+d32L418/4EefcN9GThQkDxYKfK8wgRLTFnn6bRi4PKu8rrjyGGBkmSM/CZN/ar
 62Cm5y1JzY39g4H6SPoEmpDGViF6DQ5rwnQ4oBH/SK9byeobhMsxOh22bhIv/9BKXZS8
 vtLw==
X-Gm-Message-State: AOAM530ZVUZCNCYis85RetdKxKlWDUXDK1HVaHbMVkNGpdgKzTIBsiD7
 okDtTs3aJl2QH5vmGqGx6nwscj0Y9po17Sv5ksL7N6pGhWgMUil+r1l5kvQl6VOUqZmSYAUxqpq
 zBzcCWPdKW3XZ9GeU7ydpN5cl
X-Received: by 2002:a92:db4e:: with SMTP id w14mr4382864ilq.188.1626209277264; 
 Tue, 13 Jul 2021 13:47:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlRTk8ZYwTep6uQ3YEemMecev8TKW7q7hnLoZpmdpPTnuZHGlGP2olwGFrF73D7gKpIhoktA==
X-Received: by 2002:a92:db4e:: with SMTP id w14mr4382859ilq.188.1626209277118; 
 Tue, 13 Jul 2021 13:47:57 -0700 (PDT)
Received: from gator ([140.82.166.162])
 by smtp.gmail.com with ESMTPSA id s6sm22547ilv.76.2021.07.13.13.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 13:47:56 -0700 (PDT)
Date: Tue, 13 Jul 2021 22:47:54 +0200
From: Andrew Jones <drjones@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [kvm-unit-tests PATCH v2 2/4] scripts/arch-run: don't use
 deprecated server/nowait options
Message-ID: <20210713204754.xg3eawok4m6q7ulk@gator>
References: <20210525172628.2088-1-alex.bennee@linaro.org>
 <20210525172628.2088-3-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20210525172628.2088-3-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maz@kernel.org, shashi.mallela@linaro.org,
 qemu-arm@nongnu.org, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Tue, May 25, 2021 at 06:26:26PM +0100, Alex Benn=E9e wrote:
> The very fact that QEMU drops the deprecation warning while running is
> enough to confuse the its-migration test into failing. The boolean
> options server and wait have accepted the long form options for a long
> time.
> =

> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Cc: Shashi Mallela <shashi.mallela@linaro.org>
> ---
>  scripts/arch-run.bash | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
> index 5997e38..70693f2 100644
> --- a/scripts/arch-run.bash
> +++ b/scripts/arch-run.bash
> @@ -122,14 +122,14 @@ run_migration ()
>  	trap 'kill 0; exit 2' INT TERM
>  	trap 'rm -f ${migout1} ${migsock} ${qmp1} ${qmp2} ${fifo}' RETURN EXIT
>  =

> -	eval "$@" -chardev socket,id=3Dmon1,path=3D${qmp1},server,nowait \
> +	eval "$@" -chardev socket,id=3Dmon1,path=3D${qmp1},server=3Don,wait=3Do=
ff \
>  		-mon chardev=3Dmon1,mode=3Dcontrol | tee ${migout1} &
>  =

>  	# We have to use cat to open the named FIFO, because named FIFO's, unli=
ke
>  	# pipes, will block on open() until the other end is also opened, and t=
hat
>  	# totally breaks QEMU...
>  	mkfifo ${fifo}
> -	eval "$@" -chardev socket,id=3Dmon2,path=3D${qmp2},server,nowait \
> +	eval "$@" -chardev socket,id=3Dmon2,path=3D${qmp2},server=3Don,wait=3Do=
ff \
>  		-mon chardev=3Dmon2,mode=3Dcontrol -incoming unix:${migsock} < <(cat $=
{fifo}) &
>  	incoming_pid=3D`jobs -l %+ | awk '{print$2}'`
>  =

> -- =

> 2.20.1
> =

> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

Applied to misc/queue

https://gitlab.com/rhdrjones/kvm-unit-tests/-/commits/misc/queue

Thanks,
drew

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
