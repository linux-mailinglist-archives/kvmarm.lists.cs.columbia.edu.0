Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6D61F402AEE
	for <lists+kvmarm@lfdr.de>; Tue,  7 Sep 2021 16:39:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E74304B093;
	Tue,  7 Sep 2021 10:39:28 -0400 (EDT)
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
	with ESMTP id O83EUEGCSlpw; Tue,  7 Sep 2021 10:39:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D0BE14B21E;
	Tue,  7 Sep 2021 10:39:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E8244B1E2
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Sep 2021 10:39:26 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hpkPRREhtKOe for <kvmarm@lists.cs.columbia.edu>;
 Tue,  7 Sep 2021 10:39:25 -0400 (EDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 2DCCA4B093
 for <kvmarm@lists.cs.columbia.edu>; Tue,  7 Sep 2021 10:39:25 -0400 (EDT)
Received: by mail-lf1-f51.google.com with SMTP id z2so20009946lft.1
 for <kvmarm@lists.cs.columbia.edu>; Tue, 07 Sep 2021 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x6okiQWF8AWFwYz1Cx6jMTOqJOfQYTektKqGR290ROg=;
 b=V2qEkRgiMmtEYTFLxX6J+B9SOiG5pqyIEk6sT9arTMp/i8bI0688TfDreT7NZMcLKi
 L9Pnx1OXuIi+1cpOVc7i09msj9YvfeKnBTBjqTRqYFA48qZ4gscqoBQidGUlEMBOO6f8
 iMFQkB8sPVF2+bpefC4VYQf31ojrDtyWi4TknWwpJDRd0g1N6A3VLt9YrTXcKTRacyhp
 7OtzpSCO6xBruPi96UCYckSWqfMAVNeNVabDnbl+ot9T0ExTMvb7UoKhazKaeKnenGML
 qJwu4Rylbzt0rFgXd8xURIzCzAsuZNeLpeRn0mMBr+deeD6st1CD5muzrNq04SHUE5Fg
 yzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x6okiQWF8AWFwYz1Cx6jMTOqJOfQYTektKqGR290ROg=;
 b=Z1ivDNfDW9Ur4dBJEb8mnPkb4gddsoM5kYHppq+qSOEWM1njcLgT8xFkyophNMn7+L
 yCVw52o+gfOB4uh9iaSqxIuXokI1Lwj/a9nW2Givg8Dg+1Da7SwkWssbJpF4pvGMIfah
 /beIVTQS5c/L9azmLXHDmTLYn207bFbW05Q+7WvSsIjHmga/iadr1NqjlcVTAueVon7G
 reu/HUBVxvrZZ5GugaCshevbViKwe4QxSqmQD/C7Q1meX94c0aGFHQ0JKsnqBViGU62g
 yu7WbA8JByZjWqWYjer3hvq68y3TRwfJ8YoOByEXinduWu6WoHpF1W6tHvrRBuC7kH1l
 iYZQ==
X-Gm-Message-State: AOAM530y4KrmD54plWQNn8rAhpQ/OBZ4DHIzt5i8hcbp4bQNOn6UQCGb
 iTqqNKjXUroi8NPSuITQM/XQkq53m7bvdeGyJad39ASL+9J1Yw==
X-Google-Smtp-Source: ABdhPJzVua1emB5yUEIXuBSevHAq/VVvrfNQXiKWKkwtCPQFHxdZHjnKt3AtlFnJ/ycmAv2naidJ2mOsUgS8wJ8aCaI=
X-Received: by 2002:ac2:51a2:: with SMTP id f2mr13195347lfk.685.1631025563601; 
 Tue, 07 Sep 2021 07:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210903231154.25091-1-ricarkol@google.com>
 <20210903231154.25091-3-ricarkol@google.com>
In-Reply-To: <20210903231154.25091-3-ricarkol@google.com>
From: Oliver Upton <oupton@google.com>
Date: Tue, 7 Sep 2021 09:39:12 -0500
Message-ID: <CAOQ_QshLu-EiLdPDY-d1dS3qvNjJBiN=B=a-W7_70Fdt=GbOcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: selftests: build the memslot tests for arm64
To: Ricardo Koller <ricarkol@google.com>
Cc: kvm@vger.kernel.org, maz@kernel.org, pshier@google.com,
 Paolo Bonzini <pbonzini@redhat.com>, maciej.szmigiero@oracle.com,
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

Ricardo,

On Fri, Sep 3, 2021 at 6:12 PM Ricardo Koller <ricarkol@google.com> wrote:
>
> Add memslot_perf_test and memslot_modification_stress_test to the list
> of aarch64 selftests.
>
> Signed-off-by: Ricardo Koller <ricarkol@google.com>

There isn't anything that prevents these tests from being used for
s390x too right? Of course, we haven't anything to test on but just a
thought.

Besides Drew's comments:

Reviewed-by: Oliver Upton <oupton@google.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
